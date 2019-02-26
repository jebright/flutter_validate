import './validationFailure.dart';

class ValidationResult {

  List<ValidationFailure> errors;

  ValidationResult() {
    errors = new List<ValidationFailure>();
  }

  String get errorText {
    if(errors.length == 0) return null;
    Iterable<String> text = errors.map((f) => f.errorMessage);
    return text.join(' '); //TODO: users might not want always separated by space.
  }

}