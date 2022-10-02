import 'base_validator.dart';

class NotEmptyValidator extends BaseValidator {
  NotEmptyValidator(String key) : super(key, "$key must be specified.");

  @override
  bool isValid(Object? value) => NotEmptyValidator.notEmpty(value);

  static bool notEmpty(Object? value) => notNull(value) && notEmptyString(value) && notEmptyCollection(value);

  static bool notNull(Object? value) => value != null;

  static bool notEmptyString(Object? value) {
    if (value == null || value is! String) return true;
    return value.isNotEmpty;
  }

  static bool notEmptyCollection(Object? value) {
    if (value == null || value is! Iterable) return true;
    return value.isNotEmpty;
  }
}
