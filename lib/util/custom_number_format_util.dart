import 'package:intl/intl.dart';

class CustomNumberFormatUtil {
  final oCcy = new NumberFormat("#,###.00", "en_US");
  final amountMultiplier =
      0.01; // 1250 in database will be 12.50 (its real value)

  String formatIntAsCurrency(int value) {
    var retValue = '';
    if (value != null) {
      retValue = oCcy.format(value * amountMultiplier);
    }
    return retValue;
  }

  String formatIntAsCurrencyAdd(int value, int additional) {
    value = value + additional;
    var retValue = '';
    if (value != null) {
      retValue = oCcy.format(value * amountMultiplier);
    }
    return retValue;
  }
}
