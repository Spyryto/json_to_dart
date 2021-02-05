import 'package:json_ast/json_ast.dart' show Node;
import 'package:json_to_dart/helpers.dart';

const String emptyListWarn = 'list is empty';
const String ambiguousListWarn = 'list is ambiguous';
const String ambiguousTypeWarn = 'type is ambiguous';

class Warning {
  final String warning;
  final String path;

  Warning(this.warning, this.path);
}

Warning newEmptyListWarn(String path) {
  return Warning(emptyListWarn, path);
}

Warning newAmbiguousListWarn(String path) {
  return Warning(ambiguousListWarn, path);
}

Warning newAmbiguousType(String path) {
  return Warning(ambiguousTypeWarn, path);
}

class WithWarning<T> {
  final T result;
  final List<Warning> warnings;

  WithWarning(this.result, this.warnings);
}

class TypeDefinition {
  String name;
  String? subtype;
  bool isAmbiguous;
  bool _isPrimitive = false;

  factory TypeDefinition.fromDynamic(dynamic obj, Node astNode) {
    bool isAmbiguous = false;
    final type = getTypeName(obj);
    if (type == 'List') {
      List<dynamic> list = obj;
      String elemType;
      if (list.isNotEmpty) {
        elemType = getTypeName(list[0]);
        for (dynamic listVal in list) {
          if (elemType != getTypeName(listVal)) {
            isAmbiguous = true;
            break;
          }
        }
      } else {
        // when array is empty insert Null just to warn the user
        elemType = 'String';
        // elemType = 'Null';
      }
      return TypeDefinition(type,
          astNode: astNode, subtype: elemType, isAmbiguous: isAmbiguous);
    }
    return TypeDefinition(type, astNode: astNode, isAmbiguous: isAmbiguous);
  }

  TypeDefinition(this.name,
      {this.subtype, this.isAmbiguous = false, Node? astNode}) {
    if (subtype == null) {
      _isPrimitive = isPrimitiveType(name);
      if (name == 'int' && isASTLiteralDouble(astNode)) {
        name = 'double';
      }
    } else {
      _isPrimitive = isPrimitiveType('$name<$subtype>');
    }
  }

  @override
  bool operator ==(other) {
    if (other is TypeDefinition) {
      TypeDefinition otherTypeDef = other;
      return name == otherTypeDef.name &&
          subtype == otherTypeDef.subtype &&
          isAmbiguous == otherTypeDef.isAmbiguous &&
          _isPrimitive == otherTypeDef._isPrimitive;
    }
    return false;
  }

  bool get isPrimitive => _isPrimitive;

  bool get isPrimitiveList => _isPrimitive && name == 'List';

  String _buildParseClass(String expression, bool newKeyword) {
    final properType = subtype ?? name;
    if (newKeyword) {
      return 'new $properType.fromJson($expression)';
    } else {
      return '$properType.fromJson($expression)';
    }
  }

  String _buildToJsonClass(String expression) {
    return '$expression.toJson()';
  }

  String jsonParseExpression(
    String key,
    bool privateField,
    bool newKeyword,
    bool thisKeyword,
    bool collectionLiteral,
  ) {
    final jsonKey = "json['$key']";
    String fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    if (thisKeyword) {
      fieldKey = 'this.' + fieldKey;
    }
    if (isPrimitive) {
      if (name == 'List') {
        return "$fieldKey = json['$key'].cast<$subtype>();";
      }
      return "$fieldKey = json['$key'];";
    } else if (name == 'List' && subtype == 'DateTime') {
      return "$fieldKey = json['$key'].map((v) => DateTime.tryParse(v));";
    } else if (name == 'DateTime') {
      return "$fieldKey = DateTime.tryParse(json['$key']);";
    } else if (name == 'List') {
      // list of class
      if (collectionLiteral) {
        return "if (json['$key'] != null) {\n\t\t\t$fieldKey = <$subtype>[];\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add($subtype.fromJson(v)); });\n\t\t}";
      } else {
        if (newKeyword) {
          return "if (json['$key'] != null) {\n\t\t\t$fieldKey = new List<$subtype>();\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add(new $subtype.fromJson(v)); });\n\t\t}";
        } else {
          return "if (json['$key'] != null) {\n\t\t\t$fieldKey = List<$subtype>();\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add($subtype.fromJson(v)); });\n\t\t}";
        }
      }
    } else {
      // class
      return "$fieldKey = json['$key'] != null ? ${_buildParseClass(jsonKey, newKeyword)} : null;";
    }
  }

  String jsonParseExpressionFinal(
    String key,
    bool privateField,
    bool newKeyword,
    bool thisKeyword,
    bool collectonLiteral,
  ) {
    final jsonKey = "json['$key']";
    String fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    if (isPrimitive) {
      if (name == 'List') {
        return "$fieldKey : json['$key'].cast<$subtype>(),";
      }
      return "$fieldKey : json['$key'],";
    } else if (name == 'List' && subtype == 'DateTime') {
      return "$fieldKey : json['$key'].map((v) => DateTime.tryParse(v)),";
    } else if (name == 'DateTime') {
      return "$fieldKey : DateTime.tryParse(json['$key']),";
    } else if (name == 'List') {
      // list of class
      if (newKeyword) {
        return "$fieldKey : json['$key'] != null ? List<$subtype>.from(json['$key'].map((x) => new $subtype.fromJson(x))) : null,";
      } else {
        return "$fieldKey : json['$key'] != null ? List<$subtype>.from(json['$key'].map((x) => $subtype.fromJson(x))) : null,";
      }
    } else {
      // class
      return "$fieldKey : json['$key'] != null ? ${_buildParseClass(jsonKey, newKeyword)} : null,";
    }
  }

  String toJsonExpression(String key, bool privateField, bool thisKeyword) {
    final fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    String thisKey = '$fieldKey';
    if (thisKeyword) {
      thisKey = 'this.$fieldKey';
    }
    if (isPrimitive) {
      return "__data__['$key'] = $thisKey;";
    } else if (name == 'List') {
      // class list
      return """if ($thisKey != null) {
      __data__['$key'] = $thisKey.map((v) => ${_buildToJsonClass('v')}).toList();
    }""";
    } else {
      // class
      return """if ($thisKey != null) {
      __data__['$key'] = ${_buildToJsonClass(thisKey)};
    }""";
    }
  }
}

class Dependency {
  String name;
  final TypeDefinition typeDef;

  Dependency(this.name, this.typeDef);

  String get className => camelCase(name);
}

class ClassDefinition {
  static int instanceCount = 0;
  final int id;
  String _name;
  final bool privateFields;
  final bool newKeyword;
  final bool thisKeyword;
  final bool collectionLiterals;
  final bool makePropertiesRequired;
  final bool makePropertiesFinal;
  final bool typesOnly;
  final bool fieldsOnly;
  final ClassDefinition? parentClass;
  final Map<String, TypeDefinition> fields = <String, TypeDefinition>{};

  String get name => _name;

  void rename(String name) {
    _name = name;
  }

  List<Dependency> get dependencies {
    final dependenciesList = <Dependency>[];

    fields.forEach((key, type) {
      if (!type.isPrimitive) dependenciesList.add(Dependency(key, type));
    });

    return dependenciesList;
  }

  ClassDefinition(
    String name, [
    this.privateFields = false,
    this.newKeyword = false,
    this.thisKeyword = false,
    this.collectionLiterals = true,
    this.makePropertiesRequired = false,
    this.makePropertiesFinal = false,
    this.typesOnly = false,
    this.fieldsOnly = false,
    this.parentClass,
  ])  : _name = name,
        id = instanceCount {
    instanceCount++;
  }

  @override
  bool operator ==(other) {
    if (other is ClassDefinition) {
      ClassDefinition otherClassDef = other;
      return isSubsetOf(otherClassDef) && otherClassDef.isSubsetOf(this);
    }
    return false;
  }

  bool isSubsetOf(ClassDefinition other) {
    return fields.entries.every((field) {
      var typeName = field.key;
      var typeDefinition = field.value;
      return other.fields.containsKey(typeName) &&
          other.fields[typeName] == typeDefinition;
    });
  }

  /* dynamic hasField(TypeDefinition otherField) {
    return fields.keys
            .firstWhere((k) => fields[k] == otherField, orElse: () => null) !=
        null;
  } */

  dynamic addField(String name, TypeDefinition typeDef) {
    fields[name] = typeDef;
  }

  void _addTypeDef(TypeDefinition typeDef, StringBuffer sb) {
    var name =
        typeDef.name == 'Null' ? 'String /* null supplied */' : typeDef.name;
    sb.write('$name');
    if (typeDef.subtype != null) {
      sb.write('<${typeDef.subtype}>');
    }
  }

  String get _fieldList {
    return fields.entries.map((entry) {
      var key = entry.key;
      var type = entry.value;
      final fieldName = fixFieldName(key, typeDef: type);
      final buffer = StringBuffer();
      buffer.write('\t');
      if (makePropertiesFinal) {
        buffer.write('final ');
      }
      _addTypeDef(type, buffer);
      buffer.write(' $fieldName;');
      return buffer.toString();
    }).join('\n');
  }

  String get _gettersSetters {
    return fields.entries.map((entry) {
      var key = entry.key;
      final type = entry.value;
      final publicFieldName =
          fixFieldName(key, typeDef: type, privateField: false);
      final privateFieldName =
          fixFieldName(key, typeDef: type, privateField: true);
      final buffer = StringBuffer();
      buffer.write('\t');
      _addTypeDef(type, buffer);
      buffer.write(
          ' get $publicFieldName => $privateFieldName;\n\tset $publicFieldName(');
      _addTypeDef(type, buffer);
      buffer
          .write(' $publicFieldName) => $privateFieldName = $publicFieldName;');
      return buffer.toString();
    }).join('\n');
  }

  String get _defaultPrivateConstructor {
    final buffer = StringBuffer();
    buffer.write('\t$name({');

    fields.forEach((key, type) {
      final publicFieldName =
          fixFieldName(key, typeDef: type, privateField: false);
      if (makePropertiesRequired) {
        buffer.write('@required ');
      }
      _addTypeDef(type, buffer);
      buffer.write(' $publicFieldName,');
    });

    buffer.write('}) {\n');

    fields.forEach((key, type) {
      final publicFieldName =
          fixFieldName(key, typeDef: type, privateField: false);
      final privateFieldName =
          fixFieldName(key, typeDef: type, privateField: true);
      buffer.write('this.$privateFieldName = $publicFieldName;\n');
    });

    buffer.write('}');
    return buffer.toString();
  }

  String get _defaultConstructor {
    final buffer = StringBuffer();
    buffer.write('\t$name({');

    fields.forEach((key, type) {
      final fieldName =
          fixFieldName(key, typeDef: type, privateField: privateFields);
      if (makePropertiesRequired) {
        buffer.write('@required this.$fieldName');
      } else {
        buffer.write('this.$fieldName');
      }
    });

    buffer.write('});');
    return buffer.toString();
  }

  String get _jsonParseFunc {
    final buffer = StringBuffer();
    if (makePropertiesFinal) {
      buffer.write('\tfactory $name');
      buffer.write('.fromJson(Map<String, dynamic> json) {\n');
      buffer.write('\treturn $name(\n');
      // sb.write('.fromJson(Map<String, dynamic> json) => $name(\n');

      fields.forEach((key, type) {
        buffer.write(
            '\t\t${type.jsonParseExpressionFinal(key, privateFields, newKeyword, thisKeyword, collectionLiterals)}\n');
      });

      buffer.write('\t);');
      buffer.write('}');
      return buffer.toString();
    } else {
      buffer.write('\t$name');
      buffer.write('.fromJson(Map<String, dynamic> json) {\n');
      fields.forEach((key, type) {
        buffer.write(
            '\t\t${type.jsonParseExpression(key, privateFields, newKeyword, thisKeyword, collectionLiterals)}\n');
      });
      buffer.write('\t}');
      return buffer.toString();
    }
  }

  String get _jsonGenFunc {
    final buffer = StringBuffer();
    if (collectionLiterals) {
      buffer.write(
          '\tMap<String, dynamic> toJson() {\n\t\tfinal __data__ = <String, dynamic>{};\n');
    } else {
      if (newKeyword) {
        buffer.write(
            '\tMap<String, dynamic> toJson() {\n\t\tfinal __data__ = new Map<String, dynamic>();\n');
      } else {
        buffer.write(
            '\tMap<String, dynamic> toJson() {\n\t\tfinal __data__ = Map<String, dynamic>();\n');
      }
    }
    fields.forEach((key, type) {
      buffer.write(
          '\t\t${type.toJsonExpression(key, privateFields, thisKeyword)}\n');
    });
    buffer.write('\t\treturn __data__;\n');
    buffer.write('\t}');
    return buffer.toString();
  }

  @override
  String toString() {
    if (fieldsOnly) {
      return 'class $name {\n$_fieldList\n}\n';
    } else if (typesOnly) {
      if (privateFields) {
        return 'class $name {\n$_fieldList\n\n$_defaultPrivateConstructor\n\n$_gettersSetters\n}\n';
      } else {
        return 'class $name {\n$_fieldList\n\n$_defaultConstructor\n}\n';
      }
    } else {
      if (privateFields) {
        return 'class $name {\n$_fieldList\n\n$_defaultPrivateConstructor\n\n$_gettersSetters\n\n$_jsonParseFunc\n\n$_jsonGenFunc\n}\n';
      } else {
        return 'class $name {\n$_fieldList\n\n$_defaultConstructor\n\n$_jsonParseFunc\n\n$_jsonGenFunc\n}\n';
      }
    }
  }
}
