typedef WhenPredicate<T, U> = bool Function(T value1, U value2);

mixin When {
  WhenPredicate _predicate;

  onlyWhen(WhenPredicate p) {
    _predicate = p;
  }
}
