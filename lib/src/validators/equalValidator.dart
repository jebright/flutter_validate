import 'baseValidator.dart';

///A validator used to check if two inputs are equal.
class EqualValidator extends BaseValidator {
  Function _compareTo;
  String _compareToField;

  EqualValidator(String key, Function compareTo, [String compareToField])
      : super(key, "$key is not valid") {
    _compareTo = compareTo;
    _compareToField = compareToField;
    if (_compareToField != null) {
      message = "$key must equal $_compareToField.";
    }
  }

  @override
  bool isValid(Object value) {
    return equal(value, _compareTo);
  }

  static bool equal(Object a, Function b) {
    bool equal = a == b();
    return equal;
  }
}
