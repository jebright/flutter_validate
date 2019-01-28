import 'package:flutter_validate/src/validators/lengthValidator.dart';

import './validators/notEmptyValidator.dart';
import './validators/notEqualValidator.dart';
//import './validationRule.dart';
import './ruleContainer.dart';

class RuleBuilder  {

  RuleContainer _container;
  String _key;
  RuleBuilder(String key, RuleContainer container) {
    _key = key;
    _container = container;
  }

  notEmpty() {
    var validator = new NotEmptyValidator(_key);
    _container.rules.add(validator);
  }

  notEqual(Object compareTo) {
    var validator = new NotEqualValidator(_key, compareTo);
    _container.rules.add(validator);
  }

  length(min, max) {
    var validator = new LengthValidator(_key, min, max);
    _container.rules.add(validator);
  }

  withMessage(String message) {
    var rule = _container.rules.last;
    rule.message = message;
  }

}