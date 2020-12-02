import 'baseValidator.dart';

class MaxLengthValidator extends BaseValidator {
  int _max;
  MaxLengthValidator(String key, int max)
      : super(key, "$key must be less than $max.") {
    _max = max;
  }

  @override
  bool isValid(Object value) {
    return MaxLengthValidator.length(value, _max);
  }

  static bool length(String value, max) {
    if (value == null) return true;
    return value.length <= max;
  }
}
