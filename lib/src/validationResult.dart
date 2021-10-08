import './validationFailure.dart';

class ValidationResult {
  late List<ValidationFailure> errors;
  late String _delimiter;

  ValidationResult({String delimiter = ' '}) {
    errors = List.empty();
    _delimiter = delimiter;
  }

  String? get errorText {
    if (errors.length == 0) return null;
    Iterable<String> text = errors.map((f) => f.errorMessage ?? '');
    return text.isNotEmpty ? text.join(_delimiter) : null;
  }
}
