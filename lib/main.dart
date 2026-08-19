// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'theme.dart';
import 'screens/main_view.dart';
import 'screens/d10_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(500, 780),
      minimumSize: Size(500, 780),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setTitle("Maki Dice"); 
      await windowManager.show();
      await windowManager.focus();
    });
  }

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
