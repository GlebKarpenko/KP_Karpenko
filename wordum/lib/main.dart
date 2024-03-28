import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordum/view_models/word_view.dart';
import 'package:wordum/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordView(),
      child: MaterialApp(
        title: 'Wordum',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 181, 113, 41)),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
