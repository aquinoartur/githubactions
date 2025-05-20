import 'package:flutter/cupertino.dart';

class AppThemeMode extends ValueNotifier<bool> {
  static final AppThemeMode _instance = AppThemeMode._internal();
  AppThemeMode._internal() : super(true);

  factory AppThemeMode() {
    return _instance;
  }

  bool get isDarkMode => value;

  void toggleTheme() {
    value = !value;
  }
}
