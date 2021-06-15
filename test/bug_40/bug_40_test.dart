import 'dart:io';

import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';
import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;

import 'package:json_to_dart/utils.dart';

void main() {
  group('model-generator', () {
    final currentDirectory = dirname(scriptFileOf(main));

    test('Should generate the classes to parse the JSON', () async {
      final jsonPath = normalize(join(currentDirectory, 'input.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final generator = ModelGenerator('BugForty');
      final dartCode = generator.generateDartClasses(jsonRawData);

      // Write to file for debugging purposes.
      await File(join(currentDirectory, 'output.dart'))
          .writeAsString('//@dart=2.12\n\n${dartCode.code}');

      expect(dartCode.warnings.length, equals(0));
      expect(dartCode.code.contains('class BugForty'), equals(true));
    });
  });
}
