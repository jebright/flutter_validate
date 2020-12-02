import '../../flutter_validate.dart';
import 'baseValidator.dart';

class EmailValidator extends BaseValidator {
  EmailValidator(String key)
      : super(key, "$key is not a valid email.") {
  }

  @override
  bool isValid(Object value) {
    return EmailValidator.email(value);
  }

  static bool email(String value) {
    return RegExpValidator.isValidEmailAddress(value);
  }
}
