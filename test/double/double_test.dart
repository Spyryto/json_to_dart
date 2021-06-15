import 'dart:io';
import 'package:path/path.dart' show dirname, join, normalize;
import 'package:json_ast/json_ast.dart' show LiteralNode;
import 'package:test/test.dart';

import 'package:json_to_dart/model_generator.dart';
import 'package:json_to_dart/helpers.dart' show isASTLiteralDouble;

import 'package:json_to_dart/utils.dart';

void main() {
  group('Should identify doubles and ints', () {
    final currentDirectory = dirname(scriptFileOf(main));

    test('should parse literals correctly', () {
      expect(isASTLiteralDouble(LiteralNode(1, '1')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(1e0, '1e0')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(1e1, '1e1')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(1.1e1, '1.1e1')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(10e-1, '10e-1')), isFalse);
      expect(
          isASTLiteralDouble(LiteralNode(1000.000e-1, '1000.000e-1')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(1000.0e-1, '1000.0e-1')), isFalse);
      expect(isASTLiteralDouble(LiteralNode(1000.0e-0, '1000.0e-0')), isFalse);
      expect(
          isASTLiteralDouble(LiteralNode(10.0000e-1, '10.0000e-1')), isFalse);
      expect(
          isASTLiteralDouble(LiteralNode(10.000000000000000000000000001,
              '10.000000000000000000000000001')),
          isTrue);
      expect(isASTLiteralDouble(LiteralNode(10.0, '10.0')), isTrue);
      expect(isASTLiteralDouble(LiteralNode(10.1e0, '10.1e0')), isTrue);
      expect(isASTLiteralDouble(LiteralNode(10.01e1, '10.01e1')), isTrue);
      expect(isASTLiteralDouble(LiteralNode(11e-1, '11e-1')), isTrue);
      expect(isASTLiteralDouble(LiteralNode(11.0000e-1, '11.0000e-1')), isTrue);
      expect(isASTLiteralDouble(LiteralNode(0.1, '0.1')), isTrue);
    });

    test('Should identify a double number and generate the proper type',
        () async {
      final jsonPath = normalize(join(currentDirectory, 'input.json'));
      final jsonRawData = await File(jsonPath).readAsString();
      final modelGenerator = ModelGenerator('DoubleTest');
      final dartCode = modelGenerator.generateDartClasses(jsonRawData);

      // Write to file for debugging purposes.
      await File(join(currentDirectory, 'output.dart'))
          .writeAsString('//@dart=2.12\n\n${dartCode.code}');

      final wrongDoubleRegExp = RegExp(r'^.*double int[0-9]+;$');
      final wrongIntRegExp = RegExp(r'^.*int double[0-9]+;$');
      final wrongDoubleMatch = wrongDoubleRegExp.firstMatch(dartCode.code);
      final wrongIntMatch = wrongIntRegExp.firstMatch(dartCode.code);
      expect(wrongDoubleMatch, isNull, reason: 'Wrong double found');
      expect(wrongIntMatch, isNull, reason: 'Wrong int found');
    });
  });
}
