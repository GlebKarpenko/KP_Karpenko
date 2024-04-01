import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';
import 'package:wordum/models/dictionary.dart';

class WordView extends ChangeNotifier {
  final wordGenerator = WordGenerator();
  late String newWord;

  WordView() {
    newWord = wordGenerator.randomNoun();
  }

  void getNext () async {
    List<String> words = await Dictionary.getWords();
    newWord = wordGenerator.randomNoun();
    if (words.isEmpty){
      notifyListeners();
      return;
    }

    words[words.length - 1] == newWord
        ? getNext()
        : notifyListeners();
  }

  void addWord() async {
    await Dictionary.addWord(newWord);
    notifyListeners();
  }
}
