import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dictionary extends ChangeNotifier{
  static Future<List<String>> getWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('words') ?? [];
  }  
  
  static Future<void> addWord(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = prefs.getStringList('words') ?? [];
    words.add(word);
    await prefs.setStringList('words', words);
  }

  static Future<void> removeWord(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = prefs.getStringList('words') ?? [];
    words.remove(word);
    await prefs.setStringList('words', words);
  }
}