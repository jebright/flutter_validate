import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  test('mm/dd/yyyy date, isValid called, is True', () {
    expect(DateValidator.isValidDate('02/14/2000'), true);
  });

  test('mm/dd/yy date, isValid called, is True', () {
    expect(DateValidator.isValidDate('02/14/00'), true);
  });

  test('dd/mm/yy date but en_US locale, isValid called, is False', () {
    expect(DateValidator.isValidDate('31/7/1973'), false);
  });

  test(
      'yyyy-mm-dd date, isValid called with a custom date format (ISO 8601), is True',
      () {
    expect(DateValidator.isValidDate('2000-02-14', 'yyyy-MM-dd'), true);
  });

  test(
      'yyyy-mm-dd date, isValid called with a custom date format (ISO 8601) but a bad date, is false',
      () {
    expect(DateValidator.isValidDate('2000-13-01', 'yyyy-MM-dd'),
        false); //No 13th month!
  });

  // 
  test(
      '7/10/1996 5:08 PM date and time, isValid called with a custom date format (d/M/yyyy h:m a), is true',
      () {
    expect(DateValidator.isValidDate('7/10/1996 5:08 PM', 'd/M/yyyy h:m a'),
        true);
  });  

//TODO: need test with UTC offsets (which apparently is not supported by Dart)

  test('Great Britain date (dd/mm/yy), isValid called, is True', () {
    Intl.defaultLocale = 'en_GB';
    initializeDateFormatting('en_GB', null)
        .then((x) => expect(DateValidator.isValidDate('31/7/1973'), true));
  });
}
