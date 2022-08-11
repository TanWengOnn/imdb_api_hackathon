import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:imdb_api_hackathon/theme/theme_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModal extends ChangeNotifier{
  late bool _isDark;
  late ThemeSharedPreference themeSharedPreference;
  bool get isDark => _isDark;

  ThemeModal(){
    _isDark=false;
    themeSharedPreference=ThemeSharedPreference();
  }

  set isDark(bool value){
    _isDark=value;
    themeSharedPreference.setTheme(value);
    notifyListeners();
  } 

  getThemePreferences()async{
    _isDark = await themeSharedPreference.getTheme();
    notifyListeners();
  }
}

