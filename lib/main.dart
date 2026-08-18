// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/main_view.dart';
import 'screens/d10_view.dart';

void main() {
  runApp(const MakiDiceApp());
}

class MakiDiceApp extends StatelessWidget {
  const MakiDiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maki Dice',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const MainView(),
        '/d10': (context) => const D10View(),
      },
    );
  }
}
