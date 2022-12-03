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

  //States
  String kanji = "";
  String pronun = "";

  // State of the deck before sending it to the db
  late DeckType modifiableDeck;
  // I have no fucking idea of it's purpose, but it's here
  final _formKey = GlobalKey<FormState>();
  // add methods for handling textInput
  final List<TextEditingController> _controllers = [TextEditingController(), TextEditingController()];
  // to focus specific textField
  late FocusNode focusKanji;
  late FocusNode focusPronun;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      modifiableDeck = widget.deck;
      focusKanji = FocusNode();
      focusPronun = FocusNode();
    });
  }

  @override
  Widget build(BuildContext context) {

    /**
     * Disable submit button if both kanji and pronun states are empty
     */
    bool isDisable() {
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
            margin: EdgeInsets.only(top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                            focusNode: focusKanji,
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
                            onEditingComplete: () => focusPronun.requestFocus(),
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                            focusNode: focusPronun,
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
                  ElevatedButton(
                    onPressed: () {
                      isDisable() ? // Check if form's inputs are empty
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
                      focusKanji.requestFocus();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff670D0D)),
                        )
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Color(0xff670D0D)),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () {
                  widget.update(modifiableDeck.name, modifiableDeck);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff670D0D),
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.all(20),
                ),
                child: const Text("SAVE")
            ),
          ),
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
        ],
      ),
    );
  }
}
