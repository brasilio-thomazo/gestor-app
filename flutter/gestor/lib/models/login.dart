import 'dart:convert';

class Login {
  final StringBuffer _username = StringBuffer();
  final StringBuffer _password = StringBuffer();

  void setUsername(String s) {
    _username.clear();
    _username.write(s);
  }

  void setPassword(String s) {
    _password.clear();
    _password.write(s);
  }

  get username => _username.toString();
  get password => _password.toString();

  Map<String, dynamic> toMap() {
    return {"username": username, "password": password};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
