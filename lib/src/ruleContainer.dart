import './validators/baseValidator.dart';

class RuleContainer {
  List<BaseValidator> rules = List.empty();

  Function getter;

  RuleContainer(this.getter);
}
