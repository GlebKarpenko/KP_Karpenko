import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordum/view_models/word_view.dart';

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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(word, style: style),
      ),
    );
  }
}