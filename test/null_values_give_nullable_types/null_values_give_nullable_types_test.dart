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
      .writeAsString(dartCode.code);

  test('generated code should not give warnings', () {
    expect(dartCode.warnings.isEmpty, isTrue);
  });

  test('field that can be null gives a nullable type', () {
    expect(dartCode.code.contains('List<Componenti>? componenti;'), isTrue);
    expect(dartCode.code.contains('List<Componenti>? superficie;'), isTrue);
  });
}
