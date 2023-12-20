import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Utils {
  static GlobalKey<NavigatorState> sideMenuNavigationKey = GlobalKey();
  static GlobalKey<NavigatorState> sideMenuNavigationKey2 = GlobalKey();

  String formatCurrency({double? amount = 1, int? decimalPoints = 2}) {
    final formatCurrency = NumberFormat.decimalPatternDigits(
      locale: 'en_us', // Replace with your desired currency symbol
      decimalDigits: decimalPoints, // Number of decimal places
    );
    return formatCurrency.format(amount);
  }
}
