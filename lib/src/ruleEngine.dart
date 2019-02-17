import 'package:flutter/widgets.dart';

import './validationResult.dart';
import './validationFailure.dart';
import './ruleBuilder.dart';
import './ruleContainer.dart';

//TODO: not exactly liking that we hard code a dependency on GlobalKey<FormFieldState>

class RuleEngine {
  Map<String, RuleContainer> _rules;
  Map<String, GlobalKey> _keys;

  RuleEngine() {
    _rules = Map<String, RuleContainer>();
    _keys = Map<String, GlobalKey<FormFieldState>>();
  }

  //Create a container to hold rules for a property/key
  //Use cascades to keep adding rules to that container by calling notempty.notnull.etc...
  RuleBuilder ruleFor(String key) {
    var container = new RuleContainer();
      _rules.putIfAbsent(key, () {
      _keys.putIfAbsent(key, () => GlobalKey<FormFieldState>());
      return container;
    });
    return new RuleBuilder(key, container);
  }

  GlobalKey keyFor(String key) {
    return _keys[key];
  }

  ValidationResult validate() {
    //rules.forEach(f)...

    //A validator cannot be assigned to a formfield post creation as it is declared final.


    return null;
  }

    // Returns a map of all of the heroes in context, indexed by hero tag.
  static List<FormFieldState> formFields(BuildContext context) {
    assert(context != null);
    final List<FormFieldState> result = <FormFieldState>[];
    void visitor(Element element) {
      if (element.widget is FormField) {
        final StatefulElement field = element;
        // final FormField widget = element.widget;
        // widget.validator = ();
        final FormFieldState state = field.state;
        result.add(state);
      }
      element.visitChildren(visitor);
    }
    context.visitChildElements(visitor);
    return result;
  }

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
