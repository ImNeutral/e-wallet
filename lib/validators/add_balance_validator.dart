class AddBalanceValidator {
  String amount(int _value) {
    String _error;
    if (_value <= 0) {
      _error = 'Please enter a valid amount.';
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
