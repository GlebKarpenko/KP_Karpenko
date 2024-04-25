import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/models/dictionary.dart';
import 'package:wordum/services/definition_lookup.dart';

void main() async {
  group('Dictionary tests', () {

    setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    SharedPreferences.setMockInitialValues({});
    await Dictionary.init();
    await UserSettings.init();    
    });

    test('Dictionary lookup test', () async {
      const String word = "mask";

      const Map<String, dynamic> mockDefinition = {
        'noun': '(nou) a covering to disguise or conceal the face\n'
          '(nou) activity that tries to conceal something\n'
          '(nou) a party of guests wearing costumes and masks\n'
          '(nou) a protective covering worn over the face',
        'verb': '(vrb) hide under a false appearance\n'
          '(vrb) put a mask on or cover with a mask\n'
          '(vrb) make unrecognizable\n'
          '(vrb) cover with a sauce\n'
          '(vrb) shield from light',
        'adverb': '',
        'adjective': ''
      };

      Map<String, dynamic> dictionaryWord = await DictionaryLookup().getDefinition(word);
      expect(dictionaryWord, mockDefinition);
    });
  });
}
