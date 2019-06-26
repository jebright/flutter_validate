import 'baseValidator.dart';

class LengthValidator extends BaseValidator {
  int _min;
  int _max;
  LengthValidator(String key, int min, int max)
      : super(key, "$key must be between $min and $max.") {
    _min = min;
    _max = max;
  }

  @override
  bool isValid(Object value) {
    return LengthValidator.length(value, _min, _max);
  }

  static bool length(String value, min, max) {
    if (value == null) return false;
    return value.length >= min && value.length <= max;
  }
}
