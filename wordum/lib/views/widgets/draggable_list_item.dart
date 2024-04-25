import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary_word.dart';
import 'package:wordum/models/word_editor.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/services/translation.dart';
import 'package:wordum/views/widgets/word_card.dart';

// This is a hackerton class.
// The translation and dictionary lookup service are used here temporaly.
// The functionality of searching words up will DEFINITELY be removed in future 
// once db interfaces are all good. Translation and definition should not be loaded up 
// every time a user clicks but taken from local db instead.
class DraggableListItem extends StatelessWidget{
  final String word;
  const DraggableListItem(this.word, {super.key});

  Future<Map<String, String>> getTranslation() async {
    String languageCode = UserSettings.getFavLanguageCode();
    String translation = await Translation().translate(word, languageCode);
    return {
      "language_code": languageCode,
      "translation": translation,
    };
  }

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
              // :( setting displayedWord with empty template if it is not in db
              //    or fetching word from dictionary db if present
              WordEditor editor = WordEditor();
              DictionaryWord emptyWord = editor.getEmptyWord();
              DictionaryWord displayedWord = await editor.getWord(word);

              if (displayedWord.id == emptyWord.id){
                displayedWord = DictionaryWord.setWord(emptyWord, word);
              }

              // translating word every time 'more' button is clicked
              Map<String, dynamic> translationData = await getTranslation();

              // Show details when a list item is clicked
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: WordCard(
                      displayedWord: displayedWord,
                      // set with itself if could not translate by user selected language
                      translationLanguageCode: translationData["language_code"] ?? "en",
                      translation: translationData["translation"] ?? displayedWord.word,
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