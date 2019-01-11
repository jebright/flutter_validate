import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_validate/flutter_validate.dart';

void main() {
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

// //--playing around with message
//   test('when not equal / with message, notEqual called, has proper message', () {
//       String a = 'a';
//       String b = 'b';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b');
//       expect(x.message, 'a <> b');
//   });

//   test('when equal / with message, notEqual called, has null message', () {
//       String a = 'a';
//       String b = 'a';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b')..validate();
//       expect(x.message, null);
//   });

  test('when chaining validators notEmpty & notEqual, name supplied and not equal, has 0 errors', () {
    String name = 'joe';
    var engine = new RuleEngine();
    engine.ruleFor("name")..notEmpty()..withMessage("Name should not be empty")..notEqual("frank")..withMessage("name should not equal frank");
    var validationResults = engine.validateOnly("name", name);
    expect(validationResults.errors.isEmpty, true);
  });

  test('when chaining validators notEmpty & notEqual, name empty and not equal, has 1 error with proper message', () {
    String name = '';
    var engine = new RuleEngine();
    engine.ruleFor("name")..notEmpty()..withMessage("Name should not be empty")..notEqual("frank")..withMessage("name should not equal frank");
    var validationResults = engine.validateOnly("name", name);
    expect(validationResults.errors.length, 1);
    expect(validationResults.errors[0].errorMessage, "Name should not be empty");
  });

  test('when notEmpty called, name is null and withMessage not used, returns default message', () {
    var engine = new RuleEngine();
    engine.ruleFor("Name")..notEmpty();
    var validationResults = engine.validateOnly("Name", null);
    expect(validationResults.errors[0].errorMessage, "Name must be specified");
  });

  //TODO: how to validate an entire object ????  My design so far means we have to pass in a property value when we call validateOnly.
  //how can we say engine.validate(customer) ???  

// //playing around with when
//   test('when not equal / onlyWhen, notEqual called, returns null', () {
//       String a = 'a';
//       String b = 'b';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b')..onlyWhen();
//       expect(x.message, null);
//   });

}
