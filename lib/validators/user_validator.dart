class UserValidator {
  String email(String _email) {
    String _error;
    Pattern _emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp _regex = new RegExp(_emailPattern);

    if (_email.isEmpty) {
      _error = 'Please enter a value.';
    } else if (!_regex.hasMatch(_email)) {
      _error = 'Please enter a valid email.';
    }
    return _error;
  }

  String password(String _value, bool isRegistration) {
    String _error;
    if (_value.isEmpty) {
      _error = 'Please enter your password.';
    } else if (isRegistration && _value.length < 6) {
      _error = 'Password should at least be 6 characters long.';
    }
    return _error;
  }

  String name(String _value) {
    String _error;
    if (_value.isEmpty) {
      _error = 'Please enter your name or nickname.';
    }
    return _error;
  }
}
