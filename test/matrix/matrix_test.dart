import 'dart:io';

import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';
import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;

import 'package:json_to_dart/utils.dart';

void main() {
  group('model-generator', () {
    final currentDirectory = dirname(thisScriptPath());

    test('Should generate the classes to parse the JSON', () async {
      final jsonPath = normalize(join(currentDirectory, 'input.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final generator = ModelGenerator('Matrix');
      /*
      final dartCode = generator.generateDartClasses(jsonRawData);

      // Write to file for debugging purposes.
      await File(join(currentDirectory, 'output.dart'))
        .writeAsString(dartCode.code);
      */

      // FIXME: Add matrix support
      /*
      expect(dartCode.warnings.length, equals(1));
      expect(dartCode.code.contains('class Matrix'), equals(true));
      */
    }, skip: 'matrix not implemented');
  });
}
