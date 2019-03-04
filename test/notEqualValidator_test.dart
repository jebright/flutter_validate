import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when strings a == b, notEqual called, is false', () {
    String a = 'a';
    Function b = () => 'a';
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when strings a != b, notEqual called, is true', () {
    String a = 'a';
    Function b = () => 'b';
    expect(NotEqualValidator.notEqual(a, b), true);
  });

  test('when int a == b, notEqual called, is false', () {
    int a = 1;
    Function b = () => 1;
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when int a != b, notEqual called, is true', () {
    int a = 1;
    Function b = () => 2;
    expect(NotEqualValidator.notEqual(a, b), true);
  });

  test('when Ojbect a == b, notEqual called, is false', () {
    Object a = new Object();
    Function b = () => a;
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when Object a != b, notEqual called, is true', () {
    Object a = new Object();
    Function b = () => new Object();
    expect(NotEqualValidator.notEqual(a, b), true);
  });

}
