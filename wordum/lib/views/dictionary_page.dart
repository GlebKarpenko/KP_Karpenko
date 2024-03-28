import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordum/view_models/word_view.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<WordView>();

    if (appState.wordsToLearn.isEmpty) {
      return const Center(
        child: Text('No words to learn yet'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Text('You have ${appState.wordsToLearn.length} words to learn:'),
        ),
        for (var word in appState.wordsToLearn)
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(word),
          ),
      ],
    );
  }
}
