import 'package:flutter/material.dart';
import 'package:wordum/models/translation.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String _inputText = '';
  String _translatedText = '';
  String _selectedLanguage = 'Spanish';
  String? _selectedLanguageCode = 'es';
  Map<String, String> _availableLanguages = {};

  final Translation _translation = Translation('caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e');
  final TextEditingController _outputTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              value: _selectedLanguage,
              items: _availableLanguages.entries.map((MapEntry<String, String> entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.key),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null){
                  setState(() {
                    _selectedLanguage = newValue;
                    _selectedLanguageCode = _availableLanguages[_selectedLanguage];
                  });
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
                setState(() {
                  _inputText = newValue;
                });
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
      final response = await _translation.getLanguages();
      setState(() {
        _availableLanguages = response;
      });
    } catch (e) {
      debugPrint('Error getting available languages');
    }
  }

  Future<void> _translateText() async {
    print(_selectedLanguageCode);
    try {
      final response = await _translation.translate(_inputText, _selectedLanguageCode);
      setState(() {
        _translatedText = response;
        _outputTextController.text = _translatedText;
      });
    } catch (e) {
      debugPrint('Error translating text: $e');
    }
  }
}
