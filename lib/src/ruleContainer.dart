import './validators/baseValidator.dart';

class RuleContainer {
  List<BaseValidator> rules = [];

  Function getter;

  RuleContainer(this.getter);
}
