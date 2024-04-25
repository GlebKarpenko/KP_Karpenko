import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordum/services/word_generator.dart';
import 'package:wordum/views/widgets/rounded_text_box.dart';
import 'widgets/big_card.dart';

class NewWordPage extends StatelessWidget {
  const NewWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<WordView>();
    var newWord = appState.newWord;

    IconData satisfied = Icons.sentiment_satisfied;
    IconData neutral = Icons.sentiment_neutral;
    IconData dissatisfied = Icons.sentiment_dissatisfied;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedTextBox(
            title: 'Do you know this word?',
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 16.0, 
              fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          BigCard(word: newWord),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
                icon: Icon(satisfied),
                label: const Text('Yes'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.addWord();
                  appState.getNext();
                },
                icon: Icon(neutral),
                label: const Text('Not sure'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.addWord();
                  appState.getNext();
                },
                icon: Icon(dissatisfied),
                label: const Text('No'),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
