import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test('when condition is false, wrappingValidator called, inner validator not invoked and returns true', () {
    var predicate = () { return false;};
    var innerValidator = new NotEmptyValidator("name");
    var validator = new WrappingValidator(predicate, innerValidator);
    var result = validator.isValid(null); //not empty would normally fail, but the predicate is returning false so it is not invoked.
    expect(result, true);
  });

  test('when condition is true, wrappingValidator called, inner validator invoked and returns true', () {
    var predicate = () { return true;};
    var innerValidator = new NotEmptyValidator("name");
    var validator = new WrappingValidator(predicate, innerValidator);
    var result = validator.isValid("joe");
    expect(result, true);
  });

  test('when condition is true, wrappingValidator called, inner validator invoked and returns false', () {
    var predicate = () { return true;};
    var innerValidator = new NotEmptyValidator("name");
    var validator = new WrappingValidator(predicate, innerValidator);
    var result = validator.isValid(null);
    expect(result, false);
  });

}
