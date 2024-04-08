import 'package:flutter/material.dart';
import 'package:wordum/views/widgets/word_card.dart';

class DraggableListItem extends StatelessWidget{
  final String word;
  const DraggableListItem(this.word, {super.key});

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
            onTap: () {
            // Show details when a list item is clicked
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: WordCard(
                    word: 'placeholder',
                    languageCode: 'es',
                    translation: 'translation',
                    pronunciation: 'phonetic',
                    definition: 'definition',
                  ),
                );
              });
            }
          ),
        )
      )
    );
  }
}