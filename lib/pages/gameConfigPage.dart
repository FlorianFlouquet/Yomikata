import 'package:flutter/material.dart';
import 'package:yomikata/service/deckService.dart';
import '../mongoDb.dart';
import 'flashcardsPage.dart';
import '../types/deckType.dart';
import '../components/deck.dart';
import '../components/gameMode.dart';
import '../types/cardType.dart';

class GameConfigPage extends StatefulWidget {
  const GameConfigPage({Key? key}) : super(key: key);

  final List<DeckType> decks = const [
    DeckType(
      "DECK 1",
      85,
      12,
      [
        CardType("漢字", "かんじ"),
        CardType("魅惑", "みわく"),
        CardType("付いてる","ついてる"),
      ],
    ),
    DeckType(
      "DECK 2",
      0,
      0,
      [
        CardType("謙虚", "けんきょ"),
        CardType("質素", "しっそ"),
        CardType("羽根","ばね"),
      ],
    ),
    DeckType(
      "DECK 3",
      23,
      1,
      [
        CardType("鱗", "うろこ"),
        CardType("蝋燭", "ろうそく"),
        CardType("悲嘆","ひたん"),
      ],
    ),
  ];

  @override
  State<GameConfigPage> createState() => _GameConfigPageState();
}

class _GameConfigPageState extends State<GameConfigPage> {

  late List<DeckType> _selectedDeck = [];

  late List<DeckType> decks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    var result = await DeckService.getDeck();
    for(var i = 0; i < result.length; i++) {
      List<dynamic> list = result[i]["cards"];
      List<CardType> listCards = [];
      for(var j = 0; j < list.length; j++ ) {
        listCards.add(new CardType(list[j]["kanji"], list[j]["pronun"]));
      }
      setState(() {
        decks.add(DeckType(result[i]["name"], result[i]["highscore"], result[i]["attempts"], listCards));
      });
    }
  }

  void addDeck(DeckType deck) {
    setState(() {
      _selectedDeck.add(deck);
    });
  }

  void removeDeck(DeckType deck) {
    setState(() {
      _selectedDeck.remove(deck);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color(0xff670D0D),
          title: Container(
            padding: const EdgeInsets.all(12),
            alignment: AlignmentDirectional.centerStart,
            child: const Icon(
              Icons.menu,
              size: 40,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Text(
                  'CHOOSE YOUR DECKS',
                  style: TextStyle(
                    color: Color(0xff670D0D),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            decks.isEmpty ? Text("LOADING") : Container(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: decks.map((deck) {
                  return Deck(
                    deck: deck,
                    addDeck: addDeck,
                    removeDeck: removeDeck,
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Text(
                  'CHOOSE A GAME MODE',
                  style: TextStyle(
                    color: Color(0xff670D0D),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GameMode(title: "FLASHCARDS"),
                  GameMode(title: "MCQ"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(45),
              child: TextButton(
                onPressed: _selectedDeck.length == 0 ?
                  null :
                  () {
                    print(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FlashCardsPage(deck: _selectedDeck))
                    );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _selectedDeck.length == 0 ? Colors.grey : Color(0xff670D0D),
                  padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
                ),
                child: Text(
                  "START",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}