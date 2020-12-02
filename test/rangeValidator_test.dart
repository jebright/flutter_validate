import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when value a (int) is in range, range called, is true', () {
    int test = 7;
    expect(RangeValidator.range(test, 5,10), true);
  });

  test('when value a (double) is in range, range called, is true', () {
    double test = 7.5;
    expect(RangeValidator.range(test, 5.1,10.9), true);
  });

  test('when value a (int) is under min range, range called, is false', () {
    int test = 0;
    expect(RangeValidator.range(test, 5,10), false);
  });

  test('when value a (double) is under min range, range called, is false', () {
    double test = 0.0;
    expect(RangeValidator.range(test, 5.1,10.9), false);
  });

  test('when value a (int) is over max range, range called, is false', () {
    int test = 11;
    expect(RangeValidator.range(test, 5,10), false);
  });

  test('when value a (double) is over max range, range called, is false', () {
    double test = 11.1;
    expect(RangeValidator.range(test, 5.1,10.9), false);
  });

  test('when value (int) is null, range called, does not throw', ()  {
    int test;
    expect(RangeValidator.range(test, 5,10), false);
  });

  test('when value (double) is null, range called, does not throw', ()  {
    double test;
    expect(RangeValidator.range(test, 5.1,10.9), false);
  });

}
