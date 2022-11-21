import 'package:flutter/material.dart';
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
  List<TextEditingController> _controllers = [TextEditingController(), TextEditingController()];
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
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: ListView(
        children: [
          Text("Nom du deck: ${modifiableDeck.name}"),
          Column(
            children: modifiableDeck.cards.mapIndexed((index, card) =>
              Text("${index+1} ${card.kanji} ${card.pronun}")
            ).toList(),
          ),
          Form(
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
                )
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    modifiableDeck.cards.add(CardType(kanji, pronun));
                  });
                  _controllers[0].clear();
                  _controllers[1].clear();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.all(20),
                ),
                child: const Text("ADD")
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
          )
        ],
      ),
    );
  }
}
