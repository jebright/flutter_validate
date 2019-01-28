import '../message.dart';

abstract class BaseValidator with Message {
  String _key;

  BaseValidator(String key, String defaultErrorMessage) {
    _key = key;
    message = defaultErrorMessage;
  }

  String get key {
    return _key;
  }

  bool isValid(Object value) {
    return false;
  }
}
