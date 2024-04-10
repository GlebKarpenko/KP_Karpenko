import 'dart:convert';

class DictionaryWord {
  final int id;
  final String word;
  final Map<String, dynamic> meaning;
  final List<dynamic> examples;
  final List<dynamic> associations;
  final int difficulty;
  final DateTime? dateToLearn;
  final DateTime? dateAdded;

  DictionaryWord({
    required this.id,
    required this.word,
    required this.meaning,
    required this.examples,
    required this.associations,
    required this.difficulty,
    required this.dateToLearn,
    required this.dateAdded,
  });

  DictionaryWord.copy(DictionaryWord other)
    : id = other.id,
      word = other.word,
      meaning = Map.from(other.meaning),
      examples = List.from(other.examples),
      associations = List.from(other.associations),
      difficulty = other.difficulty,
      dateToLearn = other.dateToLearn,
      dateAdded = other.dateAdded;

  DictionaryWord.setWord(DictionaryWord other, String newWord)
    : id = other.id,
      word = newWord,
      meaning = Map.from(other.meaning),
      examples = List.from(other.examples),
      associations = List.from(other.associations),
      difficulty = other.difficulty,
      dateToLearn = other.dateToLearn,
      dateAdded = other.dateAdded;

  DictionaryWord.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        word = item["word"],
        meaning = json.decode(item["meaning"]),
        examples = json.decode(item["examples"]),
        associations = json.decode(item["associations"]),
        difficulty = int.parse(item["difficulty"]),
        dateToLearn = DateTime.parse(item["date_to_learn"]),
        dateAdded = DateTime.parse(item["date_added"]);

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'word': word,
      'meaning': json.encode(meaning),
      'examples': json.encode(examples),
      'associations': json.encode(associations),
      'difficulty': difficulty,
      'date_to_learn': dateToLearn?.toIso8601String(),
      'date_added': dateAdded?.toIso8601String(),
    };
  }
}
