import 'base_validator.dart';

typedef MustPredicate<T> = bool Function(T value);

class MustValidator<T> extends BaseValidator {
  late MustPredicate<T> _predicate;

  MustValidator(String key, MustPredicate<T> p) : super(key, "$key is not valid.") {
    _predicate = p;
  }

  @override
  bool isValid(Object? value) => MustValidator.must(_predicate, value);

  static bool must<T>(MustPredicate<T> p, Object? value) => p(value as T);
}
