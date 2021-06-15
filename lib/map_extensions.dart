extension MapLoops<K, V> on Map<K, V> {
  bool any(bool Function(K key, V value) predicate) {
    return entries.any((element) => predicate(element.key, element.value));
  }

  bool every(bool Function(K key, V value) predicate) {
    return entries.every((element) => predicate(element.key, element.value));
  }
}
