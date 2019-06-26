import './validators/baseValidator.dart';

class RuleContainer {
  List<BaseValidator> rules = new List<BaseValidator>();

  Function getter;

  RuleContainer(this.getter);
}
