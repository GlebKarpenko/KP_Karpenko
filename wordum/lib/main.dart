import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wordum/models/dictionary.dart';
import 'package:wordum/models/settings.dart';
import 'package:wordum/models/word_generator.dart';
import 'package:wordum/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await UserSettings.init();
  await Dictionary.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static List<int> argb = [255, 181, 113, 41];

  MyApp({super.key}) {
    setARGB();
  }

  static void setARGB(){
    List<int> newARGB = UserSettings.getColorShemeARGB();
    if (newARGB.length == 4){
      argb = newARGB;
    }
    else {
      debugPrint('Could not get personlized color sheme, using default');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordView(),
      child: MaterialApp(
        title: 'Wordum',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(argb[0], argb[1], argb[2], argb[3])),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
