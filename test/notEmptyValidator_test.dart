import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  group('Not Empty Validator', () {
    test('null is passed, notEmpty called, is false', () {
      //final v = Validator();
      expect(NotEmptyValidator.notEmpty(null), false);
    });

    test('empty string is passed, notEmpty called, is false', () {
      expect(NotEmptyValidator.notEmpty(''), false);
    });

    test('empty collection is passed, notEmpty called, is false', () {
      List<int> emptyList = new List();
      expect(NotEmptyValidator.notEmpty(emptyList), false);
    });

    test('empty int is passed, notEmpty called, is false', () {
      int i;
      expect(NotEmptyValidator.notEmpty(i), false);
    });

    test('int of zero is passed, notEmpty called, is true', () {
      int i = 0;
      expect(NotEmptyValidator.notEmpty(i), true);
    });

    test('string of whitespace is passed, notEmpty called, is true', () {
      String s = ' ';
      expect(NotEmptyValidator.notEmpty(s), true);
    });
  });
}
