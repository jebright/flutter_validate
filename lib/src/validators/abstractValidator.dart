import 'package:flutter_validate/src/ruleBuilder.dart';
import 'package:flutter_validate/src/ruleContainer.dart';
import 'package:flutter_validate/src/validationFailure.dart';
import 'package:flutter_validate/src/validationResult.dart';
import 'package:flutter_validate/src/validators/baseValidator.dart';

abstract class AbstractValidator<T> {
  T instance;
  Map<String, RuleContainer> _rules;

  AbstractValidator(this.instance) {
    //FYI - RuleContainer is just a list of validators that are 'assigned' to a particular property to validate.
    _rules = Map<String, RuleContainer>();
  }

  ///Create a container to hold rules for a property.  The value of the 
  ///property should be returned by the passed in Function
  RuleBuilder ruleFor(String key, Function func) {
    var container = new RuleContainer(func);
    _rules.putIfAbsent(key, () {
      return container;
    });
    return new RuleBuilder(key, container);
  }

  ///Validate all rules associated with the passed in key
  ValidationResult validateRuleFor(String key) {
    var result = new ValidationResult();
    if (_rules.containsKey(key)) {
      dynamic value = _rules[key].getter();
      //Iterate each ValidationRule and invoke its validate method
      _rules[key].rules.forEach((BaseValidator r) {
        //Accumulate validation failures in order to create a validation result.
        var isValid = r.isValid(value);
        if (!isValid) {
          result.errors.add(new ValidationFailure()
            ..associatedWith = key
            ..errorMessage = r.message);
        }
      });
    }
    //TODO: throw err if key not found

    return result;
  }

  ///Validate all rules
  List<ValidationResult> validate() {
    var result = new List<ValidationResult>();
    _rules.forEach((key, container) {
      result.add(validateRuleFor(key));
    });
    return result;
  }

}
