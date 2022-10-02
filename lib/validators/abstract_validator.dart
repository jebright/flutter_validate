import 'package:flutter_validate/rule_builder.dart';
import 'package:flutter_validate/rule_container.dart';
import 'package:flutter_validate/validation_failure.dart';
import 'package:flutter_validate/validation_result.dart';

abstract class AbstractValidator<T> {
  T instance;
  late Map<String, RuleContainer> _rules;

  AbstractValidator(this.instance) {
    //FYI - RuleContainer is just a list of validators that are 'assigned' to a particular property to validate.
    _rules = <String, RuleContainer>{};
  }

  ///Create a container to hold rules for a property.  The value of the
  ///property should be returned by the passed in Function
  RuleBuilder ruleFor(String key, Function func) {
    var container = RuleContainer(func);
    _rules.putIfAbsent(key, () {
      return container;
    });
    return RuleBuilder(key, container);
  }

  ///Validate all rules associated with the passed in key
  ValidationResult validateRuleFor(String key) {
    var result = ValidationResult();
    if (_rules.containsKey(key)) {
      dynamic value = _rules[key]?.getter();
      //Iterate each ValidationRule and invoke its validate method
      if (_rules[key]?.rules.isNotEmpty == true) {
        for (var r in _rules[key]!.rules) {
          //Accumulate validation failures in order to create a validation result.
          var isValid = r.isValid(value);
          if (!isValid) {
            result.errors.add(ValidationFailure()
              ..associatedWith = key
              ..errorMessage = r.message);
          }
        }
      }
    }
    // TODO: throw err if key not found

    return result;
  }

  ///Validate all rules
  List<ValidationResult> validate() {
    var result = <ValidationResult>[];
    _rules.forEach((key, container) {
      result.add(validateRuleFor(key));
    });
    return result;
  }

  ///Returns all errors in a text format.  Errors are separated by delimiter (default is a space).
  ///IMPORTANT: Executing this method has the side-effect of also executing validate().
  String? errors() {
    var lst = validate();
    String? result = lst.fold(
        '',
        (previousValue, element) =>
            element.errorText != null ? '${previousValue ?? ''} ${element.errorText ?? ''}' : null);
    if (result == null) return null;
    return result.trim();
  }
}
