import 'validation_failure.dart';

class ValidationResult {
  late List<ValidationFailure> errors;
  late String _delimiter;

  ValidationResult({String delimiter = ' '}) {
    errors = <ValidationFailure>[];
    _delimiter = delimiter;
  }

  String? get errorText {
    if (errors.isEmpty) return null;
    Iterable<String> text = errors.map((f) => f.errorMessage ?? '');
    return text.isNotEmpty ? text.join(_delimiter) : null;
  }
}
