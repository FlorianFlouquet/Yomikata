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

  final List<DeckType> decks = const [
    DeckType("DECK 1", 85, 12),
    DeckType("DECK 2", 0, 0),
    DeckType("DECK 3", 23, 1),
  ];

  void go() {
    print("go");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Container(
            padding: const EdgeInsets.all(12),
            alignment: AlignmentDirectional.centerStart,
            child: const Icon(
              Icons.menu,
              size: 40,
            ),
          ),
          backgroundColor: Color(0xff670D0D),
        ),
        body: GameConfigPage(),
      ),
    );
  }
}