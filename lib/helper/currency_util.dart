import 'package:intl/intl.dart';

class CurrencyUtil {
  static String toIdr(int value) {
    return NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp ').format(value);
  }

  static String stringToIdr(String value) {
    double parsed = 0;
    if (value.isNotEmpty) {
      try {
        parsed = double.parse(value);
      } catch (e) {
        return 'invalid format';
      }

      return toIdr(parsed.floor());
    }
    return 'Rp. 0';
  }
}
