class AddBalanceValidator {
  String amount(String _value) {
    String _error;
    if (_value.isEmpty) {
      _error = 'Please enter the amount.';
    }
    return _error;
  }

  String description(String _value) {
    String _error;
    if (_value.isEmpty) {
      _error = 'Please enter the description.';
    }
    return _error;
  }
}
