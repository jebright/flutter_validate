import 'baseValidator.dart';
import 'package:intl/intl.dart';

class DateValidator extends BaseValidator {

  ///Note: by default the Intl library loads en_US as the defaultLocale.  However you need to change
  ///this is you plan on validating other languages.  See the Intl documentation or the accompanying
  ///unit tests for examples.
  DateValidator(String key): super(key, "$key is not valid.");

  @override
  bool isValid(Object value) {
    return isValidDate(value);
  }

  ///Validates using DateFormat.yMd.parseStrict by default.  But you can override the format you want
  ///to validate by passing in an optional format.  For example if you want to parse an ISO date, you
  ///would want to use yyyy-MM-dd as the format.  For more on supported formats, see this link:
  ///https://pub.dartlang.org/documentation/intl/latest/intl/DateFormat-class.html
  static bool isValidDate(String value, [String format]) {
    try {
      DateTime d;
      if(format == null) {
        d = new DateFormat.yMd().parseStrict(value);
      }
      else {
        d = new DateFormat(format).parseStrict(value);
      }
      print('Validated $value using the locale of ${Intl.getCurrentLocale()} - result $d');
      return true;
    } catch (e) {
      return false;
    }
  }

}
