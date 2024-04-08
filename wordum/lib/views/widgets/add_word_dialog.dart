import 'package:flutter/material.dart';
import 'package:wordum/models/dictionary.dart';

class AddWordDialog extends StatefulWidget {
  final VoidCallback onAdd;
  const AddWordDialog({required this.onAdd});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  String _inputWord = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a word'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter the word'
            ),
            onChanged: (String newValue) {
              setState(() {
                _inputWord = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
            ),
          const TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Translation',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            if (_inputWord.isNotEmpty){
              Dictionary.addWord(_inputWord);
              Navigator.of(context).pop();
              widget.onAdd();
            }
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}