import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/models/word_editor.dart';
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
            onTap: () async {
              // :(
              WordEditor editor = WordEditor();
              DictionaryWord emptyWord = editor.getEmptyWord();
              DictionaryWord displayedWord = await editor.getWord(word);

              if (displayedWord.id == emptyWord.id){
                displayedWord = DictionaryWord.setWord(emptyWord, word);
              }
              
              // Show details when a list item is clicked
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: WordCard(
                      displayedWord: displayedWord,
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