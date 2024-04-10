import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';

class WordDetails extends StatelessWidget {
  final DictionaryWord dictionaryWord;

  const WordDetails({
      super.key, 
      required this.dictionaryWord
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("my word: ${dictionaryWord.word}"),
        ],
      ),
    );
  }
}
