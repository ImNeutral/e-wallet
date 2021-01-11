import 'package:intl/intl.dart';

class CustomFormatUtil {
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

  String timeStampAsSimpleDate(DateTime date) {
    final df = new DateFormat("MMM d, ''yy\nh:mm a");
    return df.format(date);
  }

  String timeStampAsShortDate(DateTime date) {
    final df = new DateFormat("MMMM d, yyyy");
    return df.format(date);
  }
}
