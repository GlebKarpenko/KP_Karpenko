import 'package:flutter/material.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/services/translation.dart';

/// Settings page for user interaction with personalized settings.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  /// List of available languages
  Map<String, String> _availableLanguages = {};
  final Translation _translation = Translation();

  /// Currently selected language
  String _selectedLanguage = UserSettings.getFavLanguage();

  /// List of available color schemes
  final List<List<int>> _colorSchemes = [
    [255, 181, 113, 41], // Brown
    [255, 70, 68, 107], // Light Blue
  ];

  /// Currently selected color scheme
  List<int> _selectedColorScheme = UserSettings.getColorShemeARGB();

  @override
  void initState() {
    super.initState();
    _getLanguages();
  }

    /// Gets a list of languages from [_translation] service.
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select Your Language:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: _selectedLanguage,
              items: _availableLanguages.entries.map((MapEntry<String, String> entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.key),
                );
              }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
                UserSettings.setFavLanguage(_selectedLanguage);
                UserSettings.setFavLanguageCode(_availableLanguages[_selectedLanguage]!);
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Color Scheme:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade300,
            ),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _colorSchemes.map((List<int> color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorScheme = color;
                      UserSettings.setColorShemeARGB(color);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(color[0], color[1], color[2], color[3]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedColorScheme == color
                            ? Colors.black
                            : Colors.transparent,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
