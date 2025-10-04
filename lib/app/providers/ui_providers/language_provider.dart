import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage() {
    _locale = _locale == const Locale('en')
        ? const Locale('ar')
        : const Locale('en');
    notifyListeners();
  }

  

  String formatNumber(num value) {
    final localeName = _locale.toString(); // e.g., "en_US", "ar_EG"
    return NumberFormat.decimalPattern(localeName).format(value);
  }

  static String formatForBackend(DateTime dateTime) {
    // Force English locale no matter what
    return DateFormat("yyyy-MM-dd HH:mm:ss", "en").format(dateTime);
  }
}
