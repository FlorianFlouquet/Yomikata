import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  Deck({Key? key, required this.title, required this.attempts, required this.highscore}) : super(key: key);

  final String title;
  final int attempts;
  final double highscore;

  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> {

  bool clicked = false;

  void tapped() {
    setState(() {
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
                  widget.title,
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
                            "${widget.attempts}",
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
                            "${widget.highscore}%",
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