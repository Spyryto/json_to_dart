import 'dart:io';

import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() async {
  final currentDirectory = dirname(scriptFileOf(main));
  final jsonPath = normalize(join(currentDirectory, 'input.json'));
  final jsonRawData = await File(jsonPath).readAsString();

  final generator = ModelGenerator(
    'Response',
    userRenameRules: {
      'Self': 'Link',
    },
  );
  final dartCode = generator.generateDartClasses(jsonRawData);

  // Write to file for debugging purposes.
  await File(join(currentDirectory, 'output.dart'))
      .writeAsString(dartCode.code);

  test('generated code should not give warnings', () {
    showWarnings(dartCode.warnings);
    expect(dartCode.warnings.isEmpty, isTrue);
  });
  test('generated code should not have duplicate classes', () async {
    expect(dartCode.code.split('class Data').length, lessThanOrEqualTo(2));
  });

  test('generated code should have duplicate class prefixed with parent name',
      () {
    expect(dartCode.code.contains('class ResponseData'), isTrue);
  });

  test('generated code should have fields type matching renamed classes', () {
    expect(dartCode.code.contains('ResponseData data'), isTrue);
  });

  test('generated code should have renamed type declarations correctly', () {
    expect(dartCode.code.contains('Self self'), isFalse);
    expect(dartCode.code.contains('Link self'), isTrue);
  });
}
