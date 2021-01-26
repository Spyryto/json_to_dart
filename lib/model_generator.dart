import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:dart_style/dart_style.dart';
import 'package:json_ast/json_ast.dart' show parse, Settings, Node;
import 'package:json_to_dart/helpers.dart';
import 'package:json_to_dart/syntax.dart';

class DartCode extends WithWarning<String> {
  DartCode(String result, List<Warning> warnings) : super(result, warnings);

  String get code => result;
}

/// A Hint is a user type correction.
class Hint {
  final String path;
  final String type;

  Hint(this.path, this.type);
}

class ModelGenerator {
  final String _rootClassName;
  final bool _privateFields;
  final bool _newKeyword;
  final bool _thisKeyword;
  final bool _collectionLiterals;
  final bool _makePropertiesRequired;
  final bool _makePropertiesFinal;
  final bool _typesOnly;
  final bool _fieldsOnly;
  List<ClassDefinition> allClasses = <ClassDefinition>[];
  final Map<String, String> sameClassMapping = <String, String>{};
  final Map<String, String> userRenameRules;
  List<Hint> hints;

  ModelGenerator(
    this._rootClassName, {
    bool privateFields = false,
    bool newKeyword = false,
    bool thisKeyword = false,
    bool collectionLiterals = true,
    bool makePropertiesRequired = false,
    bool makePropertiesFinal = false,
    bool typesOnly = false,
    bool fieldsOnly = false,
    dynamic hints,
    Map<String, String> userRenameRules,
  })  : _privateFields = privateFields,
        _newKeyword = newKeyword,
        _thisKeyword = thisKeyword,
        _collectionLiterals = collectionLiterals,
        _makePropertiesRequired = makePropertiesRequired,
        _makePropertiesFinal = makePropertiesFinal,
        _typesOnly = typesOnly,
        _fieldsOnly = fieldsOnly,
        hints = hints ??= <Hint>[],
        userRenameRules = userRenameRules ?? {};

  Hint _hintForPath(String path) {
    return hints.firstWhere((h) => h.path == path, orElse: () => null);
  }

  List<Warning> _generateClassDefinition(
      String className, dynamic jsonRawDynamicData, String path, Node astNode) {
    List<Warning> warnings = <Warning>[];

    if (jsonRawDynamicData is List) {
      // if first element is an array, start in the first element.
      final firstNode = navigateNode(astNode, '0');
      _generateClassDefinition(
          className, jsonRawDynamicData[0], path, firstNode);
    } else {
      final jsonData = (jsonRawDynamicData as Map).map(
          (key, value) => MapEntry<String, dynamic>(key.toString(), value));
      final keys = jsonData.keys;
      ClassDefinition classDefinition = ClassDefinition(
        className,
        _privateFields,
        _newKeyword,
        _thisKeyword,
        _collectionLiterals,
        _makePropertiesRequired,
        _makePropertiesFinal,
        _typesOnly,
        _fieldsOnly,
        _parentClass(className),
      );
      _generateTypeDefinitions(
          keys, path, astNode, jsonData, warnings, classDefinition);
      _mapSimilarClasses(classDefinition);
      _generateDependencies(classDefinition, jsonData, path, warnings, astNode);
    }
    return warnings;
  }

  ClassDefinition _parentClass(String className) => allClasses.lastWhere(
      (class_) =>
          class_.dependencies.isNotEmpty &&
          class_.dependencies
              .any((dependency) => dependency.className == className),
      orElse: () => null);

  void _generateTypeDefinitions(
      Iterable<String> keys,
      String path,
      Node astNode,
      Map<String, dynamic> jsonData,
      List<Warning> warnings,
      ClassDefinition classDefinition) {
    keys.forEach((key) {
      TypeDefinition typeDef;
      final hint = _hintForPath('$path/$key');
      final node = navigateNode(astNode, key);
      if (hint != null) {
        typeDef = TypeDefinition(hint.type, astNode: node);
      } else {
        typeDef = TypeDefinition.fromDynamic(jsonData[key], node);
      }
      if (typeDef.name == 'Class') {
        typeDef.name = camelCase(key);
      }
      if (typeDef.name == 'List' && typeDef.subtype == 'Null') {
        warnings.add(newEmptyListWarn('$path/$key'));
      }
      if (typeDef.subtype != null && typeDef.subtype == 'Class') {
        typeDef.subtype = camelCase(key);
      }
      if (typeDef.isAmbiguous) {
        warnings.add(newAmbiguousListWarn('$path/$key'));
      }
      classDefinition.addField(key, typeDef);
    });
  }

  void _mapSimilarClasses(ClassDefinition classDefinition) {
    final similarClass = allClasses.firstWhere((cd) => cd == classDefinition,
        orElse: () => null);
    if (similarClass != null) {
      final similarClassName = similarClass.name;
      final currentClassName = classDefinition.name;
      sameClassMapping[currentClassName] = similarClassName;
    } else {
      allClasses.add(classDefinition);
    }
  }

  void _generateDependencies(ClassDefinition classDefinition, Map jsonRawData,
      String path, List<Warning> warnings, Node astNode) {
    final dependencies = classDefinition.dependencies;
    dependencies.forEach((dependency) {
      List<Warning> warns;
      if (dependency.typeDef.name == 'List') {
        // only generate dependency class if the array is not empty
        if (jsonRawData[dependency.name].length > 0) {
          // when list has ambiguous values, take the first one, otherwise merge all objects
          // into a single one
          dynamic toAnalyze;
          if (!dependency.typeDef.isAmbiguous) {
            WithWarning<Map> mergeWithWarning = mergeObjectList(
                jsonRawData[dependency.name], '$path/${dependency.name}');
            toAnalyze = mergeWithWarning.result;
            warnings.addAll(mergeWithWarning.warnings);
          } else {
            toAnalyze = jsonRawData[dependency.name][0];
          }
          final node = navigateNode(astNode, dependency.name);
          warns = _generateClassDefinition(dependency.className, toAnalyze,
              '$path/${dependency.name}', node);
        }
      } else {
        final node = navigateNode(astNode, dependency.name);
        warns = _generateClassDefinition(dependency.className,
            jsonRawData[dependency.name], '$path/${dependency.name}', node);
      }
      if (warns != null) {
        warnings.addAll(warns);
      }
    });
  }

  /// generateUnsafeDart will generate all classes and append one after another
  /// in a single string. The [rawJson] param is assumed to be a properly
  /// formatted JSON string. The dart code is not validated so invalid dart code
  /// might be returned
  DartCode generateUnsafeDart(String rawJson) {
    final jsonRawData = decodeJSON(rawJson);
    final astNode = parse(rawJson, Settings());
    List<Warning> warnings =
        _generateClassDefinition(_rootClassName, jsonRawData, '', astNode);
    // after generating all classes, replace the omited similar classes.
    allClasses.forEach((c) {
      final fieldsKeys = c.fields.keys;
      fieldsKeys.forEach((f) {
        final typeForField = c.fields[f];
        if (sameClassMapping.containsKey(typeForField.name)) {
          c.fields[f].name = sameClassMapping[typeForField.name];
        } else if (sameClassMapping.containsKey(typeForField.subtype)) {
          c.fields[f].subtype = sameClassMapping[typeForField.subtype];
        }
      });
    });

    _postProcess();

    return DartCode(allClasses.map((c) => c.toString()).join('\n'), warnings);
  }

  /// generateDartClasses will generate all classes and append one after another
  /// in a single string. The [rawJson] param is assumed to be a properly
  /// formatted JSON string. If the generated dart is invalid it will throw an error.
  DartCode generateDartClasses(String rawJson) {
    final unsafeDartCode = generateUnsafeDart(rawJson);
    final formatter = DartFormatter();
    return DartCode(
        formatter.format(unsafeDartCode.code), unsafeDartCode.warnings);
  }

  void _postProcess() {
    // Get class info

    var classInfo = allClasses.map((class_) => ClassInfo(
          self: class_,
          name: class_.name,
          count: allClasses.where((c) => c.name == class_.name).length,
          parent: class_.parentClass,
        ));
    classInfo.forEach((info) {
      print('${info.name}: ${info.count} (${info.parent?.name ?? ""})');
    });

    // Apply auto renamings to avoid duplicates

    var autoRenamings = classInfo.where((info) => info.count >= 2).map((info) =>
        MapEntry(info.self, "${info.parent?.name ?? ''}${info.name}"));

    if (autoRenamings.isNotEmpty) {
      print('-' * 10 + ' auto' + '-' * 10);
      autoRenamings.forEach((entry) {
        print('${entry.key.name} ---> ${entry.value}');
      });
    }

    // Apply user renamings

    var userRenamings = classInfo
        .where((info) => userRenameRules.containsKey(info.name))
        .map((info) => MapEntry(info.self, userRenameRules[info.name]));

    if (userRenamings.isNotEmpty) {
      print('-' * 10 + ' user' + '-' * 10);
      userRenamings.forEach((entry) {
        print('${entry.key.name} ---> ${entry.value}');
      });
    }

    // Try and rename classes

    autoRenamings.forEach((entry) {
      var class_ = entry.key;
      var name = entry.value;
      _renameClass(class_, name);
    });

    userRenamings.forEach((entry) {
      var class_ = entry.key;
      var name = entry.value;
      _renameClass(class_, name);
    });

    // See what comes out

    print('');
    print('-' * 10 + ' output ' + '-' * 10);
    classInfo.forEach((info) {
      var name = info.self.name;
      print('${name} (${info.parent?.name ?? ""})');
    });
    print('=' * 10 + '\n');
  }

  void _renameClass(ClassDefinition class_, String newName) {
    // Renaming this class.
    var className = class_.name;
    class_.rename(newName);

    // Searches for classes that depend on this one.
    var dependencyClasses = allClasses.where((c) =>
        c.dependencies
            .any((dependency) => dependency.typeDef.name == className) &&
        c.name == class_.parentClass.name);

    dependencyClasses.forEach((dependency) {
      // Searches for fields to rename.
      var fieldsToRename = dependency.fields.entries.where((field) {
        var type = field.value;
        return type.name == className;
      });
      // Renaming dependency fields.
      fieldsToRename.forEach((field) {
        field.value.name = newName;
      });
    });
  }
}

T out<T>(T x, [String message = '']) {
  if (message.isEmpty) {
    print(x);
  } else {
    print('$message: $x');
  }
  return x;
}

class ClassInfo {
  final ClassDefinition self;
  final String name;
  int count;
  final ClassDefinition parent;

  ClassInfo({
    @required this.self,
    @required this.name,
    @required this.count,
    @required this.parent,
  });
}
