import 'package:flutter/material.dart';
import 'package:yomikata/types/deckType.dart';

class Deck extends StatefulWidget {
  const Deck({Key? key, required this.deck, required this.addDeck, required this.removeDeck}) : super(key: key);

  final DeckType deck;
  final Function addDeck;
  final Function removeDeck;

  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> {

  bool clicked = false;

  void tapped() {
    setState(() {
      if(clicked) {
        widget.removeDeck(widget.deck);
      } else {
        widget.addDeck(widget.deck);
      }
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: Card(
        color: clicked ? Color(0xff670D0D) : Colors.white,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: Color(0xff670D0D),
              width: 2,
            )
        ),
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  widget.deck.name,
                  style: TextStyle(
                    color: clicked ? Colors.white : Color(0xff670D0D),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                alignment: AlignmentDirectional.bottomStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Attempts",
                          style: TextStyle(
                            color: clicked ? Colors.white : Color(0xff670D0D),
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 70,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.deck.attempts}",
                            style: TextStyle(
                              color: clicked ? Colors.white : Color(0xff670D0D),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Highscore",
                          style: TextStyle(
                            color: clicked ? Colors.white : Color(0xff670D0D),
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 70,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${widget.deck.highscore}%",
                            style: TextStyle(
                              color: clicked ? Colors.white : Color(0xff670D0D),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}