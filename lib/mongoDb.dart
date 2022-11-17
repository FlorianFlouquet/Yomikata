import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:yomikata/constants.dart';
import 'package:yomikata/types/deckType.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);
    return await collection.find().toList();
  }

  static save(String deckName, DeckType updatedDeck) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);

    var newCards = [];

    for(var i = 0; i < updatedDeck.cards.length; i++) {
      var card = {"kanji": updatedDeck.cards[i].kanji, "pronun": updatedDeck.cards[i].pronun};
      newCards.add(card);
    }

    collection.updateOne(
      where.eq('name', deckName), modify.set('cards', newCards)
    );
  }
}