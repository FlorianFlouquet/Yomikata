import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yomikata/components/deck.dart';
import 'package:yomikata/pages/deckMakerPage.dart';

import '../service/deckService.dart';
import '../types/cardType.dart';
import '../types/deckType.dart';

class AddDeckPage extends StatefulWidget {
  const AddDeckPage({Key? key}) : super(key: key);

  @override
  State<AddDeckPage> createState() => _AddDeckPageState();
}

class _AddDeckPageState extends State<AddDeckPage> {
  // States
  late List<DeckType> decks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  /**
   * Get all decks from DB and add them to the state "decks"
   */
  _getData() async {
    // clear the state out
    setState(() {
      decks = [];
    });
    // fetch decks and store them in a variable
    var result = await DeckService.getDeck();
    for (var i = 0; i < result.length; i++) {
      // store cards from a single deck
      List<dynamic> list = result[i]["cards"];
      List<CardType> listCards = [];
      for (var j = 0; j < list.length; j++) {
        listCards.add(CardType(list[j]["kanji"], list[j]["pronun"]));
      }
      // add the cards in a new deck which is send to decks
      setState(() {
        decks.add(DeckType(result[i]["name"], result[i]["highscore"],
            result[i]["attempts"], listCards));
      });
    }
  }

  /**
   * Update a deck by its name
   */
  _updateDeck(String deckName, DeckType updatedDeck) async {
    await DeckService.updateDeck(deckName, updatedDeck);
  }

  /**
   * Add an empty deck to the DB
   */
  _addDeck() async {
    await DeckService.addDeck();
    this._getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 90, top: 20, right: 90, bottom: 20),
          height: 50,
          child: ElevatedButton(
              onPressed: () => _addDeck(),
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff670D0D)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "New Deck",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.add_circle,
                    ),
                  )
                ],
              )),
        ),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: const Text(
            "SELECT A DECK",
            style: TextStyle(
              color: Color(0xff670D0D),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decks.isEmpty
            ? Container(
                height: 130,
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff670D0D),
                  size: 130.0,
                ),
              )
            : Column(
                children: decks
                    .map((item) => (GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  new DeckMakerPage(deck: item, update: _updateDeck)
                              ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xff670D0D),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Nombre de carte: ${item.cards.length}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )))
                    .toList(),
              ),
      ],
    );
  }
}
