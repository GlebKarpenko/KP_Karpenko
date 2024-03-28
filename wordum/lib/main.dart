import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_generator/word_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Wordum',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 181, 113, 41)),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final wordGenerator = WordGenerator();
  late String newWord;

  MyAppState(){
    newWord = wordGenerator.randomNoun();
  }

  void getNext() {
    newWord = wordGenerator.randomNoun();
    wordsToLearn[wordsToLearn.length - 1] == newWord ? getNext() : notifyListeners();
  }

  var wordsToLearn = <String>[];

  void addWord() {
    wordsToLearn.add(newWord);
    notifyListeners();
  }
}

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
      default:
        throw UnimplementedError('no widget for page with index: $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constrains) {
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
                      icon: Icon(Icons.favorite),
                      label: Text('Dictionary'),
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
      }
    );
  }
}

class NewWordPage extends StatelessWidget {
  const NewWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var newWord = appState.newWord;

    IconData satisfied = Icons.sentiment_satisfied;
    IconData neutral = Icons.sentiment_neutral;
    IconData dissatisfied = Icons.sentiment_dissatisfied;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(word: newWord),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
                icon: Icon(satisfied),
                label: const Text('Yes'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.addWord();
                  appState.getNext();
                },
                icon: Icon(neutral),
                label: const Text('Not sure'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.addWord();
                  appState.getNext();
                },
                icon: Icon(dissatisfied),
                label: const Text('No'),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(word, style: style),
      ),
    );
  }
}

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();

    if (appState.wordsToLearn.isEmpty){
      return const Center(
        child: Text('No words to learn yet'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.wordsToLearn.length} words to learn:'),
          ),
        for (var word in appState.wordsToLearn)
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(word),
          ),
      ],
    );
  }
}