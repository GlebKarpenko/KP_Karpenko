import 'package:flutter/material.dart';
import 'package:wordum/models/word_editor.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/views/widgets/word_details.dart';

class WordPage extends StatelessWidget {
  final DictionaryWord dictionaryWord;

  WordPage({super.key, required this.dictionaryWord});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word details: ${dictionaryWord.word}'),
      ),
      body: Center(
        child: Column(
          children: [
            WordDetails(dictionaryWord: dictionaryWord),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}