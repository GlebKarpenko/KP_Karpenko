import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DictionaryLookup {
  Future <Map<String, String>> getDefinition(String word) async {
    String url = "https://twinword-word-graph-dictionary.p.rapidapi.com/definition/?entry=$word";
    const Map<String, String> headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': 'caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e',
      'X-RapidAPI-Host': 'twinword-word-graph-dictionary.p.rapidapi.com',
    };

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<dynamic, dynamic> responseData = jsonDecode(response.body);
        return responseData['meaning'];
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    return {};
  }
}