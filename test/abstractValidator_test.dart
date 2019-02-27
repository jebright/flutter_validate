import 'package:flutter_test/flutter_test.dart';
import 'contact.dart';

void main() {

  Contact contact;
  ContactValidator myValidator;

  setUp(() async {
    contact = new Contact();
    myValidator = new ContactValidator(contact);
  });

  test('when notEmpty called, name is null and withMessage not used, returns default message', () {
    myValidator.ruleFor("Name", () => contact.name)..notEmpty();
    var validationResults = myValidator.validateRuleFor("Name");
    expect(validationResults.errors[0].errorMessage, "Name must be specified.");
  });  

  test('when chaining validators notEmpty & notEqual, name supplied and not equal, has 0 errors', () {
    contact.name = 'joe';
    myValidator.ruleFor("name", () => contact.name)
      ..notEmpty()
      ..withMessage("Name should not be empty")
      ..notEqual("frank")
      ..withMessage("name should not equal frank");
    var validationResults = myValidator.validateRuleFor("name");
    expect(validationResults.errors.isEmpty, true);
  });

  test('when chaining validators notEmpty & notEqual, name empty and not equal, has 1 error with proper message', () {
    contact.name = '';    
    myValidator.ruleFor("name", () => contact.name)
      ..notEmpty()
      ..withMessage("name is required!")
      ..notEqual("frank")
      ..withMessage("name should not equal frank");
    var validationResults = myValidator.validateRuleFor("name");
    expect(validationResults.errors.length, 1);
    expect(
        validationResults.errors[0].errorMessage, "name is required!");
  });

  test('when chaining validators notEqual & length & using errorText, not equal and length both fail, errorText has 2 errors separated by space', () {
    contact.name = 'admin';
    myValidator.ruleFor("name", () => contact.name)
      ..notEqual('admin')
      ..length(6, 10);
    var errorText = myValidator.validateRuleFor("name").errorText;
    expect(errorText != null, true);
    expect(errorText,"name must not equal 'admin'. name must be between 6 and 10.");
  });
}
