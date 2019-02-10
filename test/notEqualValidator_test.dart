import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when strings a == b, notEqual called, is false', () {
    String a = 'a';
    String b = 'a';
    expect(NotEqualValidator.notEqual(a, b), false);
  });

  test('when strings a != b, notEqual called, is true', () {
    String a = 'a';
    String b = 'b';
    expect(NotEqualValidator.notEqual(a, b), true);
  });

}
