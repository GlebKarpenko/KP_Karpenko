import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static late SharedPreferences _preferences;
  static const _favLanguageKey = 'favouriteLanguage';
  static const _favLanguageCodeKey = 'favouriteLanguageCode';
  static const _colorShemeARGBKey = 'colorShemeARGB';
  static const String NONE = '';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setColorShemeARGB (List<int> argb) async {
    String convertedARGB = argb.map((value) => value.toString()).join(';');
    _preferences.setString(_colorShemeARGBKey, convertedARGB);
  }

  static Future<void> setFavLanguage(String favLanguage) async {
    _preferences.setString(_favLanguageKey, favLanguage);
  }

  static Future<void> setFavLanguageCode(String favLanguageCode) async {
    _preferences.setString(_favLanguageCodeKey, favLanguageCode);
  }

  static List<int> getColorShemeARGB(){
    String convertedARGB = _preferences.getString(_colorShemeARGBKey) ?? NONE;
    return convertedARGB == NONE ? []: convertedARGB.split(';').map((value) => int.parse(value)).toList(); 
  }

  static String getFavLanguage(){
    return _preferences.getString(_favLanguageKey) ?? NONE;
  }

  static String getFavLanguageCode(){
    return _preferences.getString(_favLanguageCodeKey) ?? NONE;
  }
}