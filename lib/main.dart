import 'package:flutter/material.dart';
import './components/deck.dart';
import './components/gameMode.dart';
import './types/deckType.dart';
import './pages/gameConfigPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameConfigPage(),
    );
  }
}