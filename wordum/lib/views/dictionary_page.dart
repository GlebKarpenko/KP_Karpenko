import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary.dart';
import 'widgets/positioned_button.dart';
import 'widgets/draggable_list_item.dart';
import 'widgets/add_word_dialog.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  List<String> wordsToLearn = [];

  void fetchWordList(){
    setState(() {
      wordsToLearn = Dictionary.getWords();
    });
  }

  @override
  void initState() {
    super.initState();

    wordsToLearn = Dictionary.getWords();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: WordList(wordsToLearn: wordsToLearn,),
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
                  return AddWordDialog(
                    onAdd: fetchWordList
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        PositionedButton(
          left: 20,
          bottom: 20,
          child: TrashCan(
            onRemove: fetchWordList,
          ),),
      ],
    );
  }
}

class WordList extends StatelessWidget {
  final List<String> wordsToLearn;
  const WordList({super.key, required this.wordsToLearn});

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
          DraggableListItem(word)
      ],
    );
  }
}

class TrashCan extends StatelessWidget {
  final VoidCallback onRemove;
  const TrashCan({super.key, required this.onRemove});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      
      child: DragTarget<String>(
        onAcceptWithDetails: (dataDetails) {
          Dictionary.removeWord(dataDetails.data);
          onRemove();
        },
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
