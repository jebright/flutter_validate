import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {
  test(
      'when chaining validators notEmpty & notEqual, name supplied and not equal, has 0 errors',
      () {
    String name = 'joe';
    var engine = new RuleEngine();
    engine.ruleFor("name")
      ..notEmpty()
      ..withMessage("Name should not be empty")
      ..notEqual("frank")
      ..withMessage("name should not equal frank");
    var validationResults = engine.validateRuleFor("name", name);
    expect(validationResults.errors.isEmpty, true);
  });

  test(
      'when chaining validators notEmpty & notEqual, name empty and not equal, has 1 error with proper message',
      () {
    String name = '';
    var engine = new RuleEngine();
    engine.ruleFor("name")
      ..notEmpty()
      ..withMessage("name is required!")
      ..notEqual("frank")
      ..withMessage("name should not equal frank");
    var validationResults = engine.validateRuleFor("name", name);
    expect(validationResults.errors.length, 1);
    expect(
        validationResults.errors[0].errorMessage, "name is required!");
  });

  test(
      'when chaining validators notEqual & length & using errorText, not equal and length both fail, errorText has 2 errors separated by space',
      () {
    String name = 'admin';
    var engine = new RuleEngine();
    engine.ruleFor("Name")
      ..notEqual('admin')
      ..length(6, 10);
    var errorText = engine.validateRuleFor("Name", name).errorText;
    expect(errorText != null, true);
    expect(errorText,
        "Name must not equal 'admin'. Name must be between 6 and 10.");
  });
}
