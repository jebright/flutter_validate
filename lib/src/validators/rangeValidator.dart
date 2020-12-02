import 'baseValidator.dart';

class RangeValidator extends BaseValidator {
  num _min;
  num _max;
  RangeValidator(String key, num min, num max)
      : super(key, "$key must be between $min and $max.") {
    _min = min;
    _max = max;
  }

  @override
  bool isValid(Object value) {
    return RangeValidator.range(value, _min, _max);
  }

  static bool range(num value, min, max) {
    if (value == null) return false;
    return value >= min && value <= max;
  }
}
