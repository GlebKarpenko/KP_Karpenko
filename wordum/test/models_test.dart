import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/services/translation.dart';
import 'package:wordum/models/dictionary.dart';

void main() async {
  group('Model tests', () {

    setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    SharedPreferences.setMockInitialValues({});
    await Dictionary.init();
    await UserSettings.init();    
    });

    test('Translation test', () async {
      final translationService = Translation();

      const textToTranslate = 'hello';
      const targetLanguage = 'fr';
      final translatedText = await translationService.translate(textToTranslate, targetLanguage);

      print('text to translate: $textToTranslate');
      print('target language: $targetLanguage');
      print('translatedText: $translatedText');
      expect(translatedText, isNotNull);
      });

    test('Set and get favorite language', () async {
      String favouriteLanguage = 'Spanish';
      print('favourite language: $favouriteLanguage');

      await UserSettings.init();
      await UserSettings.setFavLanguage(favouriteLanguage);
      expect(UserSettings.getFavLanguage(), favouriteLanguage);
    });

    test('Set and get favorite language code', () async {
      String favouriteLanguageCode = 'es';
      print('favourite language code: $favouriteLanguageCode');

      await UserSettings.init();
      await UserSettings.setFavLanguageCode(favouriteLanguageCode);
      expect(UserSettings.getFavLanguageCode(), favouriteLanguageCode);
    });

    test('Set and get color sheme argb', () async {
      List<int> argb = [255, 181, 113, 41];
      print('Color Sheme ARGB: $argb');

      await UserSettings.setColorShemeARGB(argb);
      expect(UserSettings.getColorShemeARGB(), argb);
    });

    test('Get dictionary data of a word', () async {
      String word = 'test';
      String languageCode = 'en';
      print('word: $word');
      print('language code: $languageCode');

      var data = await Dictionary.getWordDictionaryData(word, languageCode);
      print(data);
      expect(data, isNotEmpty);
    });

    test('Get dictionary data about usage of a word', () async {
      String word = 'test';
      String languageCode = 'en';
      print('word: $word');
      print('language code: $languageCode');

      var data = await Dictionary.getWordUsageDictionaryData(word, languageCode);
      print(data);
      expect(data, isNotEmpty);
    });
  });
}
