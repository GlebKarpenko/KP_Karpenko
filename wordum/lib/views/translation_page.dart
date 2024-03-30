import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wordum/view_models/translation.dart';

class TranslatePage extends StatelessWidget {
  String _inputText = '';
  String _translatedText = '';
  String _selectedLanguage = 'english';
  List<String> _availableLanguages = [];

  final Translation _translation = Translation('caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e');
  final TextEditingController _outputTextController = TextEditingController();

  TranslatePage() {
    _getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              items: _availableLanguages 
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null){
                  _selectedLanguage = newValue;
                }
              },
              hint: const Text('Select Language'),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter text to translate',
                border: OutlineInputBorder(),
              ),
              onChanged: (String newValue) {
                _inputText = newValue;
              },
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Translation',
              ),
              controller: _outputTextController,
            ),
            ElevatedButton(
              onPressed: () {
                _translateText();
              },
              child: const Text('Translate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getLanguages() async {
    try {
      final response = 
        await _translation.getLanguages();
      _availableLanguages = response;
    } catch (e) {
      debugPrint('Error getting available languages');
    }
    print(_availableLanguages);
  }

  Future<void> _translateText() async {
    try {
      final response =
          await _translation.translate(_inputText, _selectedLanguage);
      _translatedText = response;
      _outputTextController.text = _translatedText;
    } catch (e) {
      debugPrint('Error translating text: $e');
    }
  }
}
