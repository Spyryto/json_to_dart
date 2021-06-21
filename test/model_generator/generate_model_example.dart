import 'dart:io';

import 'package:path/path.dart' show dirname, join, normalize;
import 'package:json_to_dart/json_to_dart.dart';
import 'package:json_to_dart/utils.dart';

void main() async {
  final classGenerator = ModelGenerator('Sample');
  final currentDirectory = dirname(scriptFileOf(main));
  final filePath = normalize(join(currentDirectory, 'sample.json'));
  final jsonRawData = await File(filePath).readAsString();
  DartCode dartCode = classGenerator.generateDartClasses(jsonRawData);
  final outputFile =
      normalize(join(dirname(currentDirectory), 'generated/', 'sample.dart'));
  await File(outputFile).writeAsString(dartCode.code);
}
