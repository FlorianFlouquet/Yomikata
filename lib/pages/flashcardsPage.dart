import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../types/cardType.dart';

class FlashCardsPage extends StatefulWidget {
  FlashCardsPage({Key? key}) : super(key: key);

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {

  final List<CardType> _deck = const [
    CardType("漢字", "かんじ"),
    CardType("魅惑", "みわく"),
    CardType("付いてる","ついてる"),
  ];

  late CardType _card;

  @override
  void initState() {
    super.initState();
    setState(() {
      _card = _deck[0];
    });
  }

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
        body: OverflowBox(
          minWidth: 0.0,
          maxWidth: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DragTarget(
                  onAccept: (data) => print("LEFT"),
                  builder: (context, _, __) => Container(
                    height: 450,
                    width: 270,
                  )
              ),
              Column(
                children: [
                  Container(
                    height: 600,
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
                                child: const Center(
                                  child: Text(
                                    "漢字",
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
                  onAcceptWithDetails: (data) => print("RIGHT"),
                  builder: (context, _, __) => Container(
                    height: 450,
                    width: 270,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
