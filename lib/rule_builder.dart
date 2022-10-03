import 'validators/date_validator.dart';
import 'validators/equal_validator.dart';
import 'validators/length_validator.dart';
import 'validators/must_validator.dart';
import 'validators/not_empty_validator.dart';
import 'validators/not_equal_validator.dart';
import 'validators/reg_exp_validator.dart';
import 'rule_container.dart';
import 'validators/wrapping_validator.dart';
import 'when.dart';

class RuleBuilder {
  late RuleContainer _container;
  late String _key;
  RuleBuilder(String key, RuleContainer container) {
    _key = key;
    _container = container;
  }

  notEmpty() {
    var validator = NotEmptyValidator(_key);
    _container.rules.add(validator);
  }

  notEqual(Function compareTo, [String compareToField = '']) {
    var validator = NotEqualValidator(_key, compareTo, compareToField);
    _container.rules.add(validator);
  }

  equal(Function compareTo, [String compareToField = '']) {
    var validator = EqualValidator(_key, compareTo, compareToField);
    _container.rules.add(validator);
  }

  length(min, max) {
    var validator = LengthValidator(_key, min, max);
    _container.rules.add(validator);
  }

  phoneNumber() {
    var validator = RegExpValidator(_key, usPhoneMatcher);
    _container.rules.add(validator);
  }

  emailAddress() {
    var validator = RegExpValidator(_key, emailMatcher);
    _container.rules.add(validator);
  }

  date() {
    var validator = DateValidator(_key);
    _container.rules.add(validator);
  }

  matches(String regex) {
    var validator = RegExpValidator(_key, regex);
    _container.rules.add(validator);
  }

  must<T>(MustPredicate<T> p) {
    var validator = MustValidator<T>(_key, p);
    _container.rules.add(validator);
  }

  withMessage(String message) {
    var rule = _container.rules.last;
    rule.message = message;
  }

  when(WhenPredicate predicate) {
    for (var f in _container.rules) {
      var validator = WrappingValidator(predicate, f);
      var index = _container.rules.indexOf(f);
      if (index > -1) {
        _container.rules[index] = validator;
      }
    }
  }
}
