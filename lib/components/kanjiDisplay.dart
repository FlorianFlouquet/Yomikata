import 'package:flutter/material.dart';

class KanjiDisplay extends StatelessWidget {
  const KanjiDisplay({Key? key, required this.index, required this.kanji, required this.pronun}) : super(key: key);
  final int index;
  final String kanji;
  final String pronun;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          top: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        color: Colors.grey[300],
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(kanji),
          ),
          Expanded(
            flex: 3,
            child: Text(pronun),
          ),
        ],
      ),
    );
  }
}
