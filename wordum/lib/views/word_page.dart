import 'package:flutter/material.dart';

class WordPage extends StatefulWidget{
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage>{
  final String response = '';
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Word details'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Respose: $response'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      );
    }
}