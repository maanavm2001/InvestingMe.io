import 'package:flutter/material.dart';
import 'package:investing_me_io/utils/local_resources.dart';
import 'package:get/get.dart';

class ThemeService {
  final _key = 'isDark';

  _saveThemeToBox(bool isDarkMode) => box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
