import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  // TODO: move these methods into new dictionary_word_lookup service; 
  //  use this API instead: https://rapidapi.com/twinword/api/word-dictionary/
  static Future<Map<String, String>> getWordDictionaryData(String word, String languageCode) async{
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/$languageCode/$word';
    Map<String, String> wordDictionaryData = {};

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body)[0];
        wordDictionaryData['phonetic'] = responseData['phonetic'] ?? '';
        wordDictionaryData['partOfSpeech'] = responseData['meanings'][0]['partOfSpeech'] ?? '';
        wordDictionaryData['definition'] = responseData['meanings'][0]['definitions'][0]['definition'] ?? '';

        return wordDictionaryData;
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    return wordDictionaryData;
  }

  static Future<Map<String, dynamic>> getWordUsageDictionaryData(String word, String languageCode) async{
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/$languageCode/$word';
    Map<String, dynamic> wordUsageDictionaryData = {};

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic> definitions = responseData[0]['meanings'][0]['definitions'][0];
        wordUsageDictionaryData['key'] = 'value';
        
        List<String> keys = ['synonyms', 'antonyms', 'example'];
        for (String key in keys) {
          if (definitions.containsKey(key)){
            wordUsageDictionaryData[key] = definitions[key];
          } else {
            wordUsageDictionaryData[key] = '';
          }
        }

        return wordUsageDictionaryData;
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return wordUsageDictionaryData;
  }
}