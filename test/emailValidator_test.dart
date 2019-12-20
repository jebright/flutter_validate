import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when a is email, email called, is true', () {
    String test = 'a@b.com';
        expect(EmailValidator.email(test), true);
  });

  test('when a is not email, email called, is false', () {
    String test = 'a@b';
        expect(EmailValidator.email(test), false);
  });

  test('when a is null, email called, does not throw', ()  {
    String test;
    expect(EmailValidator.email(test), true);
  });

}