import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/services/sqlite_service.dart';

class WordEditor {
  final SqliteService sqliteService = SqliteService();

  DictionaryWord getEmptyWord() {
    return DictionaryWord(
      id: -1, 
      word: "", 
      meaning: {}, 
      examples: [], 
      associations: [], 
      difficulty: -1, 
      dateToLearn: null, 
      dateAdded: null
    );
  }

  Future<DictionaryWord> getWord(String word) async {
    var result = await sqliteService.getWord(word);
    if (result == null){
      DictionaryWord emptyWord = getEmptyWord();
      return emptyWord;
    }
    else {
      return result;
    }
  }

  Future<void> updateWord(DictionaryWord word) async {
    try {
      if (word.id != -1){
        await sqliteService.updateWord(word);
        return;
      }
      await sqliteService.createWord(word);
    } catch (e) {
      debugPrint('Failed to add word: $word. Error: $e');
    }
  }
}