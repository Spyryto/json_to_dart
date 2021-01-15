import 'dart:io';
import 'package:json_to_dart/model_generator.dart';
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() {
  group('model-generator-with-warnings', () {
    final currentDirectory = dirname(thisScriptPath());
    test('should generate proper warnings', () async {
      final jsonPath = normalize(join(currentDirectory, 'input.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final ModelGenerator modelGenerator = ModelGenerator('Warnings');
      DartCode dartCode = modelGenerator.generateUnsafeDart(jsonRawData);

      // Write to file for debugging purposes.
      await File(join(currentDirectory, 'output.dart'))
          .writeAsString(dartCode.code);

      expect(dartCode.warnings, isNot(null));
      expect(dartCode.warnings.length, equals(2));
      expect(dartCode.warnings[0].warning, equals('list is ambiguous'));
      expect(dartCode.warnings[0].path, equals('/ambiguousArray'));
      expect(dartCode.warnings[1].warning, equals('type is ambiguous'));
      expect(dartCode.warnings[1].path, equals('/ambiguous[2]/arr[0]/amb'));
    });
  });
}
