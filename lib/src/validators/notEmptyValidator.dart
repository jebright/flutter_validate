import 'baseValidator.dart';

class NotEmptyValidator extends BaseValidator {
  NotEmptyValidator(String key) : super(key, "$key must be specified.");

  @override
  bool isValid(Object value) {
    return NotEmptyValidator.notEmpty(value);
  }

  static bool notEmpty(Object value) {
    return notNull(value) && notEmptyString(value) && notEmptyCollection(value);
  }

  static bool notNull(Object value) {
    return value != null;
  }

  static bool notEmptyString(Object value) {
    if (value is! String) return true;
    return (value as String).isNotEmpty;
  }

  static bool notEmptyCollection(Object value) {
    if (value is! Iterable) return true;
    return (value as Iterable).isNotEmpty;
  }
}
