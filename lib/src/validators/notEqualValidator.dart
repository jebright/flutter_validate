import 'baseValidator.dart';

///A validator used to check if two inputs are not equal.
class NotEqualValidator extends BaseValidator {
  
//TODO: need to support more than just strings

  Object _compareTo;
  NotEqualValidator(String key, Object compareTo): super(key, "$key must not equal '$compareTo'.") {
    _compareTo = compareTo;
  }

  @override
  bool isValid(Object value) {
    return notEqual(value, _compareTo);
  }

  static bool notEqual(String a, String b) {
    bool equal = a == b;
    return !equal;
  }

}
