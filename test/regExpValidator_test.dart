import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test(
      'valid US phone # without dashes or parenthesis, isValid called, is True',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('5596732076'), true);
  });

  test(
      'valid US phone # with dashes but no parenthesis, isValid called, is True',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('559-673-2076'), true);
  });

  test('valid US phone # with dashes and parenthesis, isValid called, is True',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('(559) 673-2076'), true);
  });

    test('valid US phone # with spaces, isValid called, is True',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('559 673 2076'), true);
  });

  test('valid Australia phone # with spaces, isValid called for US #, is false',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('+61 2 9192 0995'), false);
  });
  
  test('valid Mexico phone # with dashes, isValid called for US #, is True',
      () {
    expect(RegExpValidator.isValidUSPhoneNumber('+52-624-142-9999'), false);
  });

  test('valid email, isValid called, is True',
      () {
    expect(RegExpValidator.isValidEmailAddress('joe@joe.com'), true);
  });

  test('bad email, isValid called, is False',
      () {
    expect(RegExpValidator.isValidEmailAddress('joe.com'), false);
  });
}
