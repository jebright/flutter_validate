import 'base_validator.dart';

const String usPhoneMatcher =
    r'^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
const String emailMatcher =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

///A validator used to validate using regular expressions.  Out of the box we have various
///expressions ready for use - such as phone #s and email addresses.  But you may always
///add your own.
class RegExpValidator extends BaseValidator {
  late RegExp _regex;

  RegExpValidator(String key, String expression) : super(key, "$key is not valid.") {
    _regex = RegExp(expression);
  }

  @override
  bool isValid(Object? value) => value == null || _regex.hasMatch(value as String);

  static bool isValidUSPhoneNumber(String? value) {
    RegExp r = RegExp(usPhoneMatcher);
    return value == null || r.hasMatch(value);
  }

  static bool isValidEmailAddress(String? value) {
    RegExp r = RegExp(emailMatcher);
    return value == null || r.hasMatch(value);
  }
}
