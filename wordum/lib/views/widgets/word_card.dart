import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/views/word_page.dart';

class WordCard extends StatelessWidget {
  final DictionaryWord displayedWord;
  final String translationLanguageCode;
  final String translation;

  final TextStyle wordStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  final TextStyle textStyle = const TextStyle(fontSize: 16.0);

  WordCard({
    super.key, 
    required this.displayedWord,
    required this.translationLanguageCode,
    required this.translation,
  });

  String getDefinition(){
    Map<String, dynamic> meanings = displayedWord.meaning;
    if (meanings.isNotEmpty){
      return meanings.entries.first.toString();
    }
    return "click more to add definition";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayedWord.word,
              style: wordStyle,
            ),
            const SizedBox(height: 8.0),
            Text('($translationLanguageCode) $translation', style: textStyle,),
            const SizedBox(height: 8.0),
            Text(getDefinition(), style: textStyle,),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {             
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordPage(
                      dictionaryWord: displayedWord,
                    )));
                  },
                  child: const Text('More'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
