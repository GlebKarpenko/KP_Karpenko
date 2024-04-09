import 'package:flutter/material.dart';
import 'package:wordum/views/word_page.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String languageCode;
  final String translation;
  final String pronunciation;
  final String definition;

  final TextStyle wordStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  final TextStyle textStyle = const TextStyle(fontSize: 16.0);

  const WordCard({super.key, 
    required this.word,
    required this.languageCode,
    required this.translation,
    required this.pronunciation,
    required this.definition,
  });

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
              word,
              style: wordStyle,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(pronunciation, style: textStyle,),
                const SizedBox(width: 16.0),
                Text('($languageCode) $translation', style: textStyle,),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(definition, style: textStyle,),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordPage()));
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
