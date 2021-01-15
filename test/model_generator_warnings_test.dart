import 'dart:io';
import 'package:json_to_dart/model_generator.dart';
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() {
  group('model-generator-with-warnings', () {
    final currentDirectory = dirname(thisScriptPath());
    test('should generate proper warnings', () async {
      final jsonPath = normalize(join(currentDirectory, 'test_warnings.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final ModelGenerator modelGenerator = ModelGenerator('Warnings');
      DartCode dartCode = modelGenerator.generateUnsafeDart(jsonRawData);
      expect(dartCode.warnings, isNot(null));
      expect(dartCode.warnings.length, equals(4));
      expect(dartCode.warnings[0].warning, equals('list is ambiguous'));
      expect(dartCode.warnings[0].path, equals('/ambiguousArray'));
      expect(dartCode.warnings[1].warning, equals('list is empty'));
      expect(dartCode.warnings[1].path, equals('/emptyArr'));
      expect(dartCode.warnings[2].warning, equals('type is ambiguous'));
      expect(dartCode.warnings[2].path, equals('/ambiguous[2]/arr[0]/amb'));
      expect(dartCode.warnings[3].warning, equals('list is empty'));
      expect(dartCode.warnings[3].path, equals('/ambiguous/arr/emptyArr'));
    });
  });
}
