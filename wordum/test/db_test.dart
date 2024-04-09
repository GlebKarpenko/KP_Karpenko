import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/services/sqlite_service.dart';
import 'package:logger/logger.dart';

void main() async {
  group('DatabaseTests', () { 
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });
  });

  test('CRUD operations test', () async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      
      SqliteService sqliteService = SqliteService();
      final database = sqliteService.initializeDB();

      var testWord = DictionaryWord(
      id: 0,
      word: "mask",
      meaning: {
        "adjective": "",
        "adverb": "",
        "noun": "(nou) a covering to disguise or conceal the face (nou) activity that tries to conceal something (nou) a party of guests wearing costumes and masks (nou) a protective covering worn over the face",
        "verb": "(vrb) hide under a false appearance (vrb) put a mask on or cover with a mask (vrb) make unrecognizable (vrb) cover with a sauce (vrb) shield from light",
      },
      examples: [
        "The red figure wears the same hat and mask in the background.",
        "The conformable mask is then stripped and a new conformable mask laid down.",
        "She was wearing a Kachina dancer's mask.",
        "The grandiosity is just a momentary mask.",
        "The mask is for protection and intimidation.",
        "The grating in the mask is adjusted.",
        "The mask of the male mummy is gilded.",
        "The mask covers the aperture of the telescope.",
        "Mask and wig celebrates the centennial of the clubhouse.",
        "The latter disguised his scarred visage with a steel mask.",
      ],
      associations: [
        "hide",
        "hat",
        "face",
      ],
      difficulty: 3,
      dateToLearn: DateTime(6, 1, 2024), 
      dateAdded: DateTime(1, 1, 2024),
    );

    var logger = Logger();

    logger.log(Level.trace, 'insert entry into words table');
    await sqliteService.createWord(testWord);

    logger.log(Level.trace, "get entry of the words table");
    var words = await sqliteService.getWords();
    for (var word in words){
      print(word.id);
      print(word.word);
      print(word.meaning);
      print(word.associations);
      print(word.dateToLearn);
    }

    logger.log(Level.trace, 'update an entry of the words table');
    await sqliteService.updateWord(testWord);
    words = await sqliteService.getWords();
    for (var word in words){
      print(word.id);
      print(word.word);
      print(word.meaning);
      print(word.associations);
      print(word.dateToLearn);
    }

    logger.log(Level.trace, 'delete an entry of the words table');
    await sqliteService.deleteWord(testWord);
    words = await sqliteService.getWords();
    for (var word in words){
      print(word.id);
      print(word.word);
      print(word.meaning);
      print(word.associations);
      print(word.dateToLearn);
    }
  });
}