import 'package:intl/intl.dart';

import 'baseValidator.dart';

///A validator used to validate dates that originate from an input string.  Any locale
///supported by Dart is supported here, but en_US is the default.  There is a dependency
///on Intl.dart so you will need to set Intl.defaultLocale (e.g. Intl.defaultLocale = 'en_GB')
///and call initializeDateFormatting.  See the unit tests for an example.
class DateValidator extends BaseValidator {
  ///Note: by default the Intl library loads en_US as the defaultLocale.  However you need to change
  ///this is you plan on validating other languages.  See the Intl documentation or the accompanying
  ///unit tests for examples.
  DateValidator(String key) : super(key, "$key is not valid.");

  @override
  bool isValid(Object? value) {
    return isValidDate(value as String);
  }

  ///Validates using DateFormat.yMd.parseStrict by default.  But you can override the format you want
  ///to validate by passing in an optional format.  For example if you want to parse an ISO date, you
  ///would want to use yyyy-MM-dd as the format.  For more on supported formats, see this link:
  ///https://pub.dartlang.org/documentation/intl/latest/intl/DateFormat-class.html
  static bool isValidDate(String value, [String? format]) {
    try {
      DateTime d;
      if (format == null) {
        d = new DateFormat.yMd().parseStrict(value);
      } else {
        d = new DateFormat(format).parseStrict(value);
      }
      //print('Validated $value using the locale of ${Intl.getCurrentLocale()} - result $d');
      return d != null;
    } catch (e) {
      return false;
    }
  }
}
