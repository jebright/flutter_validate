import 'baseValidator.dart';

class NotEqualValidator extends BaseValidator {
  
//TODO: need to support more than just strings

  Object _compareTo;
  NotEqualValidator(String key, Object compareTo): super(key, "TODO") {
    _compareTo = compareTo;
  }

  @override
  bool isValid(Object value) {
    return notEqual(value, _compareTo);
  }

  bool notEqual(String a, String b) {
    bool equal = a == b;
    if(equal) message = null;
    return !equal;
  }



}
