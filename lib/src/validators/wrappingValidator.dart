import 'package:flutter_validate/src/when.dart';

import 'baseValidator.dart';

class WrappingValidator extends BaseValidator {
  late WhenPredicate _condition;
  late BaseValidator _innerValdiator;
  WrappingValidator(WhenPredicate condition, BaseValidator innerValidator)
      : super(innerValidator.key, innerValidator.message) {
    _condition = condition;
    _innerValdiator = innerValidator;
  }

  @override
  bool isValid(Object? value) {
    if (_condition()) {
      return _innerValdiator.isValid(value);
    }
    return true;
  }
}
