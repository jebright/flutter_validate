import './validationFailure.dart';

class ValidationResult {
  List<ValidationFailure> errors;
  String _delimiter;

  ValidationResult({String delimeter = ' '}) {
    errors = new List<ValidationFailure>();
    _delimiter = delimeter;
  }

  String get errorText {
    if (errors.length == 0) return null;
    Iterable<String> text = errors.map((f) => f.errorMessage);
    return text.join(_delimiter);
  }
}
