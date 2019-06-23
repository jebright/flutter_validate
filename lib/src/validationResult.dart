import './validationFailure.dart';

class ValidationResult {
  List<ValidationFailure> errors;

  ValidationResult() {
    errors = new List<ValidationFailure>();
  }

  String get errorText {
    Iterable<String> text = errors.map((f) => f.errorMessage);
    return text.isNotEmpty
        ? text.join(' ')
        : null; //TODO: users might not want always separated by space.
  }
}
