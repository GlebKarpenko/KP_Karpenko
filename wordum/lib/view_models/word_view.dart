import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';

class WordView extends ChangeNotifier {
  final wordGenerator = WordGenerator();
  late String newWord;

  WordView() {
    newWord = wordGenerator.randomNoun();
  }

  void getNext() {
    newWord = wordGenerator.randomNoun();
    wordsToLearn[wordsToLearn.length - 1] == newWord
        ? getNext()
        : notifyListeners();
  }

  var wordsToLearn = <String>[];

  void addWord() {
    wordsToLearn.add(newWord);
    notifyListeners();
  }
}
