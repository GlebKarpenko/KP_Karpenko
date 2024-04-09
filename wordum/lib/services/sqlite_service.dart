import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wordum/models/dictionary_word.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE words(id INTEGER PRIMARY KEY AUTOINCREMENT, word VARCHAR NOT NULL, meaning TEXT, examples TEXT, associations TEXT, difficulty VARCHAR, date_to_learn DATETIME, date_added DATETIME)",
        );
      },
     version: 1,
    );
  }

  Future<void> createWord(DictionaryWord word) async {
    final Database db = await initializeDB();
    await db.insert(
      'words', 
      word.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );   
  }

  Future<List<DictionaryWord>> getWords() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> wordMaps = await db.query('words');
    return wordMaps.map((e) => DictionaryWord.fromMap(e)).toList();
  }

  Future<void> updateWord(DictionaryWord word) async {
    final Database db = await initializeDB();
    await db.update(
      'words', 
      word.toMap(), 
      where: 'id = ?',
      whereArgs: [word.id],
    );
  }

  Future<void> deleteWord(DictionaryWord word) async {
    final db = await initializeDB();
    await db.delete(
      'words',
      where: 'id = ?',
      whereArgs: [word.id],
    );
  }
}