import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart'; // Import your DictionaryWord model

class WordDetails extends StatelessWidget {
  final DictionaryWord dictionaryWord;

  WordDetails({
      Key? key, 
      required this.dictionaryWord
    }) : super(key: key);

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
