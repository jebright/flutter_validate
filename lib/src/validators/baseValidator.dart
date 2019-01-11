import '../message.dart';

abstract class BaseValidator with Message {

  String _key;
  //String _defaultErrorMessage;
  

  BaseValidator(String key, String defaultErrorMessage) {
    _key = key;
    message = defaultErrorMessage;
   // _defaultErrorMessage = defaultErrorMessage;
  }

  bool isValid(Object value) {
    return false;
  }
}