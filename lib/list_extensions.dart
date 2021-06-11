extension NullableSeasch<T> on List<T> {
  T? firstElementWhere(bool Function(T item) predicate) {
    for (var element in this) {
      if (predicate(element)) return element;
    }
  }

  T? lastElementWhere(bool Function(T item) predicate) {
    for (var element in reversed) {
      if (predicate(element)) return element;
    }
  }
}
