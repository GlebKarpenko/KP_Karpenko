import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Translation extends ChangeNotifier{
  final String apiKey;

  Translation(this.apiKey);

   Future<Map<String, String>> getLanguages() async {
    Map<String, String> languages = {};
    try {
      final json = await rootBundle.loadString(
        'assets/config/languages.json',
      );

      Map<String, dynamic> jsonData = jsonDecode(json);
      jsonData['translation'].forEach((key, value) {
        String languageName = value['name'];
        String languageCode = key;
        if (!languages.containsKey(languageName)) {
          languages[languageName] = (languageCode);
        }
      });
    } catch (e) {
      debugPrint('Failed to get language data: $e');
    }
    return languages;
  }

  Future<String> translate(String text, String? targetLanguage, {String sourceLanguage = 'English'}) async {
    String url = 'https://microsoft-translator-text.p.rapidapi.com/translate?to%5B0%5D=$targetLanguage&api-version=3.0&profanityAction=NoAction&textType=plain';
    const Map<String, String> headers = {
      "content-type": "application/json",
      "X-RapidAPI-Key": "caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e",
      "X-RapidAPI-Host": "microsoft-translator-text.p.rapidapi.com"
    };
    final List<Map<String, String>> body = [
      {'Text': text}
    ];

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData[0]['translations'][0]['text'];
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return '';
  }
}