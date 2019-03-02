import 'baseValidator.dart';

final String usPhoneMatcher = r'^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
final String emailMatcher = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

class RegExpValidator extends BaseValidator {
  
  RegExp _regex;

  RegExpValidator(String key, String expression): super(key, "$key is not valid.") {
    _regex = new RegExp(expression);
  }

  @override
  bool isValid(Object value) {
    return _regex.hasMatch(value);
  }

  static bool isValidUSPhoneNumber(String value) {
    RegExp r = new RegExp(usPhoneMatcher);
    return r.hasMatch(value);
  }

  static bool isValidEmailAddress(String value) {
    RegExp r = new RegExp(emailMatcher);
    return r.hasMatch(value);
  }

}
