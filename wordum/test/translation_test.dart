import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordum/models/translation.dart';

void main() {
  group('Models tests', () {
    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
    });

    test('Translation test', () async {
      const apiKey = 'caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e';
      final translationService = Translation(apiKey);

      final textToTranslate = 'hello';
      final targetLanguage = 'fr';
      final translatedText = await translationService.translate(textToTranslate, targetLanguage);

      print('text to translate: $textToTranslate');
      print('target language: $targetLanguage');
      print('translatedText: $translatedText');
      expect(translatedText, isNotNull);
    });
  });
}
