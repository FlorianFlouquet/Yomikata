import 'package:flutter/material.dart';
import 'package:yomikata/components/kanjiDisplay.dart';
import 'package:yomikata/types/cardType.dart';
import 'package:yomikata/types/deckType.dart';
import 'package:collection/collection.dart';

class DeckMakerPage extends StatefulWidget {
  const DeckMakerPage({Key? key, required this.deck, required this.update}) : super(key: key);

  final DeckType deck;
  final Function update;

  @override
  State<DeckMakerPage> createState() => _DeckMakerPageState();
}

class _DeckMakerPageState extends State<DeckMakerPage> {

  late DeckType modifiableDeck;
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [TextEditingController(), TextEditingController()];
  String kanji = "";
  String pronun = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      modifiableDeck = widget.deck;
    });
  }

  @override
  Widget build(BuildContext context) {

    bool _isDisable() {
      if(kanji == "" && pronun == "") {
        return true;
      }
      return false;
    }

    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Color(0xff670D0D),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 40,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Nom du deck: ${modifiableDeck.name}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            children: modifiableDeck.cards.mapIndexed((index, card) =>
              KanjiDisplay(index: index, kanji: card.kanji, pronun: card.pronun)
            ).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: _controllers[0],
                            decoration: InputDecoration(
                                hintText: 'Kanji',
                                suffixIcon: IconButton(
                                  onPressed: _controllers[0].clear,
                                  icon: const Icon(Icons.clear),
                                )
                            ),
                            onChanged: (value) {
                              setState(() {
                                kanji = _controllers[0].text;
                              });
                            },
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllers[1],
                          decoration: InputDecoration(
                            hintText: 'Pronunciation',
                            suffixIcon: IconButton(
                              onPressed: _controllers[1].clear,
                              icon: const Icon(Icons.clear),
                            )
                          ),
                          onChanged: (value) {
                            setState(() {
                              pronun = _controllers[1].text;
                            });
                          },
                        )
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _isDisable() ?
                      null :
                      setState(() {
                        modifiableDeck.cards.add(CardType(kanji, pronun));
                      });
                      _controllers[0].clear();
                      _controllers[1].clear();
                      setState(() {
                        kanji = "";
                        pronun = "";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(bottom: 19, left: 35, top: 19, right: 35),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("ADD")
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                widget.update(modifiableDeck.name, modifiableDeck);
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.all(20),
                ),
                child: const Text("SAVE")
            ),
          ),
        ],
      ),
    );
  }
}
