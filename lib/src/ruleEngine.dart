import 'package:flutter/widgets.dart';

import './validationResult.dart';
import './validationFailure.dart';
import './ruleBuilder.dart';
import './ruleContainer.dart';

class RuleEngine {
  Map<String, RuleContainer> _rules;
  //Map<String, GlobalKey> _keys;

  RuleEngine() {
    _rules = Map<String, RuleContainer>();
   // _keys = Map<String, GlobalKey<FormFieldState>>();
  }

  //Create a container to hold rules for a property/key
  //Use cascades to keep adding rules to that container by calling notempty.notnull.etc...
  RuleBuilder ruleFor(String key) {
    var container = new RuleContainer(null);
      _rules.putIfAbsent(key, () {
      //_keys.putIfAbsent(key, () => GlobalKey<FormFieldState>());
      return container;
    });
    return new RuleBuilder(key, container);
  }

  // GlobalKey keyFor(String key) {
  //   return _keys[key];
  // }

  //TODO: not implemented yet...
  // ValidationResult validate() {
  //   //rules.forEach(f)...

  //   return null;
  // }

  ValidationResult validateRuleFor(String key, Object value) {
    var result = new ValidationResult();
    if (_rules.containsKey(key)) {
      //Iterate each ValidationRule and invoke its validate method
      _rules[key].rules.forEach((r) {
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
}
