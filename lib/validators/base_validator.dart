import '../message.dart';

abstract class BaseValidator with Message {
  late String _key;

  BaseValidator(String key, String defaultErrorMessage) {
    _key = key;
    message = defaultErrorMessage;
  }

  String get key => _key;

  bool isValid(Object? value) => false;
}
