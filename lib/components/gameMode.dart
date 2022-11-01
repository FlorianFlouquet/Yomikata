import 'package:flutter/material.dart';

class GameMode extends StatefulWidget {
  const GameMode({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GameMode> createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {

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
              color: Color(0xff0670D0D),
              width: 2,
            )
        ),
        child: SizedBox(
          width: 250,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.info_outline,
                    color: clicked ? Colors.white : Color(0xff670D0D),
                  ),
                ),
              ),
              Center(
                child: Center(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: clicked ? Colors.white : Color(0xff670D0D),
                    ),
                  ),
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
