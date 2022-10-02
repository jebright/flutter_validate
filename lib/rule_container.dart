import 'validators/base_validator.dart';

class RuleContainer {
  List<BaseValidator> rules = <BaseValidator>[];

  Function getter;

  RuleContainer(this.getter);
}
