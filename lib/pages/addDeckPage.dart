import 'package:flutter/material.dart';

class AddDeckPage extends StatefulWidget {
  const AddDeckPage({Key? key}) : super(key: key);

  @override
  State<AddDeckPage> createState() => _AddDeckPageState();
}

class _AddDeckPageState extends State<AddDeckPage> {

  final _formKey = GlobalKey<FormState>();

  String _deckName = '';
  String _text1 = '';
  String _text2 = '';

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Text("Nom du Deck: "),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _deckName = value;
                    });
                  },
                )
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Text("Kanji"),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    setState(() {
                      _text1 = value;
                    });
                  },
                ),
                Text("Pronunciation"),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    setState(() {
                      _text2 = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Text(_text1),
          Text(_text2),
          Text(_deckName),
          ElevatedButton(
              onPressed: () {
                _formKey.currentState!.validate();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xff670D0D),
              ),
              child: Icon(Icons.add)
          ),
        ],
      );
  }
}
