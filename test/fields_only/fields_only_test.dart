import 'dart:io';

import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() async {
  final currentDirectory = dirname(scriptFileOf(main));
  final jsonPath = normalize(join(currentDirectory, 'input.json'));
  final jsonRawData = await File(jsonPath).readAsString();

  final generator =
      ModelGenerator('Response', fieldsOnly: true, makePropertiesFinal: false);
  final dartCode = generator.generateDartClasses(jsonRawData);

  // Write to file for debugging purposes.
  await File(join(currentDirectory, 'output.dart.md'))
      .writeAsString('```dart\n${dartCode.code}\n```');

  test('generated code should not give warnings', () {
    showWarnings(dartCode.warnings);
    expect(dartCode.warnings.isEmpty, equals(true));
  });
  test('generated code should not have constructors', () async {
    expect(dartCode.code.contains('this.'), equals(false));
  });

  test('generated code should be a data structure', () {
    expect(dartCode.code, contains('''
class Dati {
  String codiceAzienda;
  String codiceAnagrafico;
  String codiceServizio;
}
'''));
  });
}
