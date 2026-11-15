// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'theme.dart';
import 'screens/main_view.dart';
import 'screens/d10_view.dart';
import 'widgets/choosers.dart';

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
      home: const RootView(),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final labelColor = labelColorOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _selectedTab,
                children: const [MainView(), D10View()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PageChooser(
                selectedIndex: _selectedTab,
                onSelect: (index) => setState(() => _selectedTab = index),
                items: [
                  ('Calculator', DiceIcon(color: _selectedTab == 0 ? Colors.white : labelColor)),
                  (
                    'D10',
                    Text(
                      'D10',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: _selectedTab == 1 ? Colors.white : labelColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
