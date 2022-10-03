import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('must, predicate returns true, is valid', () {
    func(int value) => value > 0;
    expect(MustValidator.must(func, 1), true);
  });

  test('must, predicate returns false, is not valid', () {
    func(int value) => value > 0;
    expect(MustValidator.must(func, 0), false);
  });

  test('must, pass in property value & predicate returns false, is not valid', () {
    String name = 'fred';
    func(String value) {
      return value != name;
    }

    expect(MustValidator.must(func, name), false);
  });
}
