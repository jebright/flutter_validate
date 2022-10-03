import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when strings a == b, notEqual called, is false', () {
    String a = 'a';
    b() => 'a';
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when strings a != b, notEqual called, is true', () {
    String a = 'a';
    b() => 'b';
    expect(NotEqualValidator.notEqual(a, b), true);
  });

  test('when int a == b, notEqual called, is false', () {
    int a = 1;
    b() => 1;
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when int a != b, notEqual called, is true', () {
    int a = 1;
    b() => 2;
    expect(NotEqualValidator.notEqual(a, b), true);
  });

  test('when Ojbect a == b, notEqual called, is false', () {
    Object a = Object();
    b() => a;
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when Object a != b, notEqual called, is true', () {
    Object a = Object();
    b() => Object();
    expect(NotEqualValidator.notEqual(a, b), true);
  });
}
