//import './validationRule.dart';
import './validationResult.dart';
import './validationFailure.dart';
import './ruleBuilder.dart';
import './ruleContainer.dart';

class RuleEngine {
  Map<String, RuleContainer> rules;

  RuleEngine() {
    rules = Map<String, RuleContainer>();
  }

  /*
  create a container to hold rules for a property/key
  use cascades to keep adding rules to that container by calling notempty.notnull.etc...
  */

  RuleBuilder ruleFor(String key) {
    var container = new RuleContainer();
    rules.putIfAbsent(key, () => container);
    // _addRule(key, container);
    return new RuleBuilder(key, container);
  }

  // void _addRule(String key, RuleContainer container) {
    
  //   // if(!rules.containsKey(key))
  //   // {
  //   //   rules[key] = new RuleContainer();
  //   // }
  //   // else {
  //   //   rules[key] = container;
  //   // }
  // }

  // void _addRule(String key, ValidationRule rule) {
  //   //var values = rules.putIfAbsent(key, () => new List<ValidationRule>()..add(rule));
  //   if(!rules.containsKey(key))
  //   {
  //     rules[key] = new List<ValidationRule>()..add(rule);
  //   }
  //   else {
  //     rules[key].add(rule);
  //   }
  // }

  //TODO: not implemented yet...
  ValidationResult validate() {
    //rules.forEach(f)...

    return null;
  }

  ValidationResult validateOnly(String key, Object value) {
    var result = new ValidationResult();
    if(rules.containsKey(key)) {
      //Iterate each ValidationRule and invoke its validate method
      rules[key].rules.forEach((r)
        {
          //Accumulate validation failures in order to create a validation result.
          var isValid = r.isValid(value);
          if(!isValid) {
            result.errors.add(new ValidationFailure()..associatedWith = key..errorMessage=r.message);
          }
        }
      );
    }
    //TODO: throw err if key not found

    return result;
  }
}
