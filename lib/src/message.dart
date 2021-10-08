mixin Message {
  late String _message;
  String get message => _message;
  set message(String s) {
    _message = s;
  }
}
