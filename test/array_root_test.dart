import 'dart:io';

import 'package:path/path.dart' show dirname, join, normalize;
import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() {
  group('model-generator', () {
    final currentDirectory = dirname(thisScriptPath());

    test('Should generate the classes to parse the JSON', () async {
      final jsonPath = normalize(join(currentDirectory, 'array_root.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final generator = ModelGenerator('ArrayRoot');
      final dartCode = generator.generateDartClasses(jsonRawData);
      expect(dartCode.warnings.length, equals(0));
      expect(dartCode.code.contains('class GlossDiv'), equals(true));
    });
  });
}
