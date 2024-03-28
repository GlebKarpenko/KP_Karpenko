import 'package:flutter/material.dart';

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

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
              onChanged: (String? newValue) {},
              hint: const Text('Select Language'),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter text to translate',
                border: OutlineInputBorder(),
              ),
              onChanged: (String newValue) {},
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Translation',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
