import 'dart:io';

import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() async {
  final currentDirectory = dirname(scriptFileOf(main));
  final jsonPath = normalize(join(currentDirectory, 'input.json'));
  final jsonRawData = await File(jsonPath).readAsString();

  final generator = ModelGenerator('Response');
  final dartCode = generator.generateDartClasses(jsonRawData);

  // Write to file for debugging purposes.
  await File(join(currentDirectory, 'output.dart'))
      .writeAsString('//@dart=2.12\n\n${dartCode.code}');

  test('generated code should not give warnings', () {
    showWarnings(dartCode.warnings);
    expect(dartCode.warnings.isEmpty, equals(true));
  });
  test('generated code should not have lists of nulls', () async {
    expect(dartCode.code.contains('List<Null>'), equals(false));
    expect(dartCode.code.contains('Null.fromJson(v)'), equals(false));
  });

  test(
      'generated code should have List<String> instead of List<Null> by default',
      () {
    expect(dartCode.code.contains('List<Null>'), equals(false));
    expect(dartCode.code.contains('List<String>'), equals(true));
  });
}
