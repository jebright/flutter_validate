import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when string a is less than max, length called, is true', () {
    String test = '1234567890';
    expect(MaxLengthValidator.length(test, 10), true);
  });

  test('when string a is over max range, length called, is false', () {
    String test = '123456789012345';
    expect(MaxLengthValidator.length(test, 10), false);
  });

  test('when string is null, length called, does not throw', ()  {
    String test;
    expect(MaxLengthValidator.length(test, 10), true);
  });

}
