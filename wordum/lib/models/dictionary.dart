import 'package:shared_preferences/shared_preferences.dart';

class Dictionary {
  static late SharedPreferences _preferences;
  static const _keyWordList = 'words';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static List<String> getWords() {
    return _preferences.getStringList(_keyWordList) ?? [];
  }

  static Future<void> addWord(String word) async {
    List<String> words = _preferences.getStringList(_keyWordList) ?? [];
    words.add(word);
    _preferences.setStringList(_keyWordList, words);
  }

  static Future<void> removeWord(String word) async {
    List<String> words = _preferences.getStringList(_keyWordList) ?? [];
    words.remove(word);
    _preferences.setStringList(_keyWordList, words);
  }
}