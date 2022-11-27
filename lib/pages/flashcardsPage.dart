import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:yomikata/types/deckType.dart';
import '../types/cardType.dart';

class FlashCardsPage extends StatefulWidget {
  FlashCardsPage({Key? key, required this.deck}) : super(key: key);

  List<DeckType> deck;

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  List<CardType> deck = [];
  late CardType _card;
  bool gameEnded = false;
  late String _draggedCardText;

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var i = 0; i < widget.deck.length; i++) {
        for (var j = 0; j < widget.deck[i].cards.length; j++) {
          deck.add(widget.deck[i].cards[j]);
        }
      }
      deck.shuffle();
      _card = deck[0];
      _draggedCardText = _card.kanji;
    });
  }

  void wrong() {
    setState(() {
      deck.removeAt(0);
      deck.add(_card);
      _card = deck[0];
      _draggedCardText = _card.kanji;
    });
  }

  void right() {
    setState(() {
      deck.removeAt(0);
      if (deck.isNotEmpty) {
        _card = deck[0];
        _draggedCardText = _card.kanji;
      } else {
        setState(() {
          gameEnded = true;
        });
      }
    });
  }

  void changeDraggedCardText() {
    setState(() {
      if(_draggedCardText == _card.kanji) {
        _draggedCardText = _card.pronun;
      } else {
        _draggedCardText = _card.kanji;
      }
    });
  }

  void onDraggableCancelled(Velocity velocity, Offset offest) {
    setState(() {
      _draggedCardText = _card.kanji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Color(0xff670D0D),
      ),
      body: !gameEnded
          ? OverflowBox(
        minWidth: 0.0,
        maxWidth: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DragTarget(
                onAccept: (data) => wrong(),
                builder: (context, _, __) =>
                    Container(
                      height: 450,
                      width: 270,
                    )),
            Column(
              children: [
                Container(
                  height: 550,
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Stack(
                      children: [
                        Transform(
                          transform: Matrix4.rotationZ(3),
                          alignment: FractionalOffset.center,
                          child: Container(
                            width: 270,
                            height: 450,
                            child: Card(
                              color: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.rotationZ(0.2),
                          alignment: FractionalOffset.center,
                          child: Container(
                            width: 270,
                            height: 450,
                            child: Card(
                              color: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Draggable(
                          onDraggableCanceled: onDraggableCancelled,
                          data: "OUI",
                          feedback: Container(
                            width: 270,
                            height: 450,
                            child: Card(
                              color: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.orange,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _draggedCardText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            width: 270,
                            height: 400,
                            color: const Color.fromRGBO(0, 0, 0, 0),
                          ),
                          child: FlipCard(
                            onFlip: changeDraggedCardText,
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            front: Container(
                              width: 270,
                              height: 450,
                              child: Card(
                                color: Colors.grey[300],
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _card.kanji,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            back: Card(
                              color: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _card.pronun,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "click on the card to flip it",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            DragTarget(
                onAcceptWithDetails: (data) => right(),
                builder: (context, _, __) =>
                    Container(
                      height: 450,
                      width: 270,
                    )),
          ],
        ),
      )
          : Center(
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(30),
                height: 100,
                width: 200,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff670D0D),
                  ),
                  child: Text(
                    'Homepage',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                height: 100,
                width: 200,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff670D0D)),
                  child: Text(
                    'Text review',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
