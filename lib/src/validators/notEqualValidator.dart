import 'baseValidator.dart';

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

  bool notEqual(String a, String b) {
    bool equal = a == b;
    if(!equal) message = null;
    return !equal;
  }



}
