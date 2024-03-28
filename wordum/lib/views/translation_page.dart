import 'package:flutter/material.dart';
import 'package:wordum/view_models/translation.dart';

class TranslatePage extends StatelessWidget {
  TranslatePage({super.key});
  var _inputText = '';
  var _translatedText = '';
  var _selectedLanguage = 'english';

  final Translation _translation = Translation('caecaa083bmsh63028a0fa2649c7p1ca969jsna79169fea24e');
  final TextEditingController _outputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              items: <String>['English', 'Spanish', 'French', 'German']
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
              decoration: InputDecoration(
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

  Future<void> _translateText() async {
    try {
      final translatedText =
          await _translation.translate(_inputText, 'es');
      _translatedText = translatedText;
      _outputTextController.text = _translatedText;
    } catch (e) {
      debugPrint('Error translating text: $e');
    }
  }
}
