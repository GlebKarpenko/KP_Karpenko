import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordum/models/word_generator.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage>{  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: WordList(),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: SizedBox(
            width: 66,
            height: 66,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context){
                      return _AddWordDialog();
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          )
        ),
      ],
    );
  }
}

class WordList extends StatelessWidget {
  const WordList({super.key});

  @override 
  Widget build(BuildContext context){
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

class _AddWordDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a word'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter the word'
            ),
          ),
          SizedBox(
            height: 10,
            ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Translation'
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
