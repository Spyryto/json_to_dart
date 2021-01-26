import 'dart:io';

import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() async {
  final currentDirectory = dirname(thisScriptPath());
  final jsonPath = normalize(join(currentDirectory, 'input.json'));
  final jsonRawData = await File(jsonPath).readAsString();

  final generator = ModelGenerator('Response');
  final dartCode = generator.generateDartClasses(jsonRawData);

  // Write to file for debugging purposes.
  await File(join(currentDirectory, 'output.dart'))
      .writeAsString(dartCode.code);

  test('generated code should not give warnings', () {
    expect(dartCode.warnings.isEmpty, isTrue);
  });

  test('generated code maps equal classes to the same', () async {
    expect(dartCode.code.contains('class Componenti '), isTrue);
    expect(dartCode.code.contains('<Componenti>'), isTrue);

    expect(dartCode.code.contains('class Superficie '), isFalse);
    expect(dartCode.code.contains('<Superficie>'), isFalse);
  });
}
