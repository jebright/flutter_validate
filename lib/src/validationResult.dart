import './validationFailure.dart';

class ValidationResult {

  List<ValidationFailure> errors;

  ValidationResult() {
    errors = new List<ValidationFailure>();
  }

}