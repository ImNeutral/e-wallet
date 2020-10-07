class UserValidator {
  String email(String _email) {
    _email = _email.trim();
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
    RegExp _hasLetter = new RegExp(r"[a-zA-Z]");
    RegExp _hasNumber = new RegExp(r"[0-9]");
    if (_value.isEmpty) {
      _error = 'Please enter your password.';
    } else if (isRegistration && _value.length < 6) {
      _error = 'Password should at least be 6 characters long.';
    } else if (isRegistration && _value.length >= 50) {
      _error = 'Password should at be less than 50 characters long.';
    } else if (isRegistration &&
        (!_hasLetter.hasMatch(_value) || !_hasNumber.hasMatch(_value))) {
      _error = 'Password should contain a letter and a number.';
    }
    return _error;
  }

  String confirmPassword(String password, String confirmPassword) {
    String _error;
    if (password != confirmPassword) {
      _error = 'Password does not match.';
    }
    return _error;
  }

  String firstName(String _value) {
    String _error;
    _value = _value.trim();
    if (_value.isEmpty) {
      _error = 'Please enter your First Name';
    }
    return _error;
  }

  String lastName(String _value) {
    String _error;
    _value = _value.trim();
    if (_value.isEmpty) {
      _error = 'Please enter your Last Name';
    }
    return _error;
  }
}
