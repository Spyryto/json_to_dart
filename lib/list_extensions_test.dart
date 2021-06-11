import 'package:test/test.dart';
import 'list_extensions.dart';

void main() {
  group('first', () {
    test('element that satisfies predicate is found', () {
      var firstEven = [1, 2, 3].firstElementWhere((n) => n.isEven);
      expect(firstEven, 2);
    });

    test('element that satisfies predicate is not found', () {
      var firstEven = [1, 3, 5].firstElementWhere((n) => n.isEven);
      expect(firstEven, isNull);
    });
  });

  group('last', () {
    test('element that satisfies predicate is found', () {
      var lastEven = [1, 2, 3].lastElementWhere((n) => n.isEven);
      expect(lastEven, 2);
    });

    test('element that satisfies predicate is not found', () {
      var lastEven = [1, 3, 5].lastElementWhere((n) => n.isEven);
      expect(lastEven, isNull);
    });
  });
}
