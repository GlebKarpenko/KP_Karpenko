import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/models/translation.dart';

class DictionaryWord {
  String name;
  late Map<String, dynamic> dictionaryData;
  late Map<String, dynamic> usageDictionaryData;
  late String translation;
  DateTime dateAdded;

  DictionaryWord({
    required this.name,
    required this.dateAdded,
    dictionaryData,
    usageDictionaryData,
    translation,
  });

  Future<void> setTranslation() async{
    const apiKey = 'caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e';
    Translation translationService = Translation(apiKey);
    String userLanguage = UserSettings.getFavLanguage();

    try {
      final response = await translationService.translate(name, userLanguage);
      translation = response;
    } catch (e) {
      debugPrint('Error translating word with user language: $e');
      translation = name;
    }
  }

  Future<void> setDictionaryData() async {
    String userLanguage = UserSettings.getFavLanguage();
    try {
      final response = await Dictionary.getWordDictionaryData(name, userLanguage);
      dictionaryData = response;
    } catch (e) {
      debugPrint('Error getting dictionary data for word: $name. Exception: $e');
    }
  }

  Future<void> setUsageDictionaryData() async {
    String userLanguage = UserSettings.getFavLanguage();
    try {
      final response = await Dictionary.getWordUsageDictionaryData(name, userLanguage);
      dictionaryData = response;
    } catch (e) {
      debugPrint('Error getting dictionary data for word: $name. Exception: $e');
    }
  }
}