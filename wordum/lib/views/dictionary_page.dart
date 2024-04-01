import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: WordList(),
        ),
        PositionedButton(
          right: 20,
          bottom: 20,
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
        const PositionedButton(
          left: 20,
          bottom: 20,
          child: TrashCan(),),
      ],
    );
  }
}

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  List<String> wordsToLearn = [];

  @override
  void initState() {
    super.initState();
    _fetchWords();
  }

  Future<void> _fetchWords() async {
    try {
      List<String> words = await Dictionary.getWords();
      setState(() {
        wordsToLearn = words;
      });
    } catch (e) {
      debugPrint('Error getting word list: $e');
    }
  }

  @override 
  Widget build(BuildContext context){
    if (wordsToLearn.isEmpty) {
      return const Center(
        child: Text('No words to learn yet'),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Text('You have ${wordsToLearn.length} words to learn:'),
        ),
        for (var word in wordsToLearn)
          _DraggableListItem(word)
      ],
    );
  }
}

class _DraggableListItem extends StatelessWidget{
  final String word;
  const _DraggableListItem(this.word);

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        
        child: Draggable<String>(
          data: word,
          feedback: Material(
            // make SizedBox invisible cuz it gets in a way of displaying round corners
            color: Colors.transparent,
            child: SizedBox(
              width: 300,
              height: 100,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: Text(word),
                ),
              ),
            ), 
          ),
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: Text(word),
          ),
        )
      )
    );
  }
}

class PositionedButton extends StatelessWidget{
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;

  const PositionedButton({
    required this.child,

    // Set with wrong value that will not be rendered
    this.top = double.infinity,
    this.bottom = double.infinity,
    this.left = double.infinity,
    this.right = double.infinity,

    super.key,
  });

  @override
  Widget build(BuildContext context){
    return Positioned(

      // Dont specify positioning if not set
      top: top != double.infinity ? top : null,
      bottom: bottom != double.infinity ? bottom : null,
      left: left != double.infinity ? left : null,
      right: right != double.infinity ? right : null,

      child: SizedBox(
        width: 66,
        height: 66,
        child: FittedBox(
          child: child,
        ),
      )
    );
  }
}

class TrashCan extends StatelessWidget {
  const TrashCan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return const Icon(
            Icons.delete,
            size: 66,
          );
        },
      ),
    );
  }
}

class _AddWordDialog extends StatefulWidget {
  @override
  State<_AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<_AddWordDialog> {
  String _inputWord = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a word'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter the word'
            ),
            onChanged: (String newValue) {
              setState(() {
                _inputWord = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
            ),
          const TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Translation',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            if (_inputWord.isNotEmpty){
              Dictionary.addWord(_inputWord);
              Navigator.of(context).pop();
            }
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
