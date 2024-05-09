import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';

/// Page about details of a word.
/// 
/// The page for adding and displaying all word data as in [DictionaryWord] model.
class WordPage extends StatelessWidget {
  final DictionaryWord dictionaryWord;
  final String translation;

  final TextStyle headerStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  final TextStyle labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
  final TextStyle bodyStyle = const TextStyle(fontSize: 16.0);

  const WordPage({
      super.key, 
      required this.dictionaryWord,
      required this.translation,
    });

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word details: ${dictionaryWord.word}'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dictionaryWord.word, style: headerStyle),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('translation: ', style: labelStyle),
                      Text(translation, style: bodyStyle),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Definition',
                        border: OutlineInputBorder(),
                      ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Save')
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back')
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}