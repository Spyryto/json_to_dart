import 'package:test/test.dart';

import 'map_extensions.dart';

void main() {
  group('any', () {
    test('returns true if all elements satisfy predicate', () {
      var map = {'A': 65, 'B': 66, 'C': 67};
      var result = map
          .any((character, asciiCode) => character.codeUnitAt(0) == asciiCode);
      expect(result, true);
    });
    test('returns true if some elements satisfy predicate', () {
      var map = {'A': 65, 'b': 66, 'C': 67};
      var result = map
          .any((character, asciiCode) => character.codeUnitAt(0) == asciiCode);
      expect(result, true);
    });
    test('returns false if none of the elements satisfy predicate', () {
      var map = {'a': 65, 'b': 66, 'c': 67};
      var result = map
          .any((character, asciiCode) => character.codeUnitAt(0) == asciiCode);
      expect(result, false);
    });
  });

  group('every', () {
    test('returns true if all elements satisfy predicate', () {
      var map = {'A': 65, 'B': 66, 'C': 67};
      var result = map.every(
          (character, asciiCode) => character.codeUnitAt(0) == asciiCode);
      expect(result, true);
    });
    test('returns false if not all elements satisfy predicate', () {
      var map = {'A': 65, 'b': 66, 'C': 67};
      var result = map.every(
          (character, asciiCode) => character.codeUnitAt(0) == asciiCode);
      expect(result, false);
    });
  });
}
