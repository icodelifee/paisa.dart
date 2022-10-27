// copied from https://github.com/dart-lang/collection/blob/master/lib/src/iterable_extensions.dart#L244
extension IterableX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
