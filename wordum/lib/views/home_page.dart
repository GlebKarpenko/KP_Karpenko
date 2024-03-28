import 'package:flutter/material.dart';
import 'package:wordum/views/new_word_page.dart';
import 'package:wordum/views/dictionary_page.dart';
import 'package:wordum/views/translation_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const NewWordPage();
        break;
      case 1:
        page = const DictionaryPage();
        break;
      case 2:
        page = TranslatePage();
        break;
      default:
        throw UnimplementedError(
            'no widget for page with index: $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constrains.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.book),
                    label: Text('Dictionary'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.language),
                    label: Text('Translation'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
