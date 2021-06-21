import 'dart:io';

import 'package:json_to_dart/json_to_dart.dart' show ModelGenerator;
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:test/test.dart';

import 'package:json_to_dart/utils.dart';

void main() async {
  final currentDirectory = dirname(scriptFileOf(main));
  final jsonPath = normalize(join(currentDirectory, 'input.json'));
  final jsonRawData = await File(jsonPath).readAsString();

  test('data map in method toJson() should not have a type annotation',
      () async {
    final generator = ModelGenerator('Response');
    final dartCode = generator.generateDartClasses(jsonRawData);

    // Write to file for debugging purposes.
    await File(join(currentDirectory, 'output.dart'))
        .writeAsString(dartCode.code);

    expect(dartCode.warnings.isEmpty, equals(true));
    expect(dartCode.code.contains('final Map<String, dynamic> data ='),
        equals(false));
  });
}
