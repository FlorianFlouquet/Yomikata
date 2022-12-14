import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:yomikata/constants.dart';
import 'package:yomikata/types/deckType.dart';

class MongoDatabase {
  /**
   * Return all documents from the user collection
   */
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);
    return await collection.find().toList();
  }

  /**
   * Update a deck with new cards
   */
  static save(String deckName, DeckType updatedDeck) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);

    var newCards = [];

    for(var i = 0; i < updatedDeck.cards.length; i++) {
      var card = {
        "kanji": updatedDeck.cards[i].kanji,
        "pronun": updatedDeck.cards[i].pronun
      };
      newCards.add(card);
    }

    collection.updateOne(
      where.eq('name', deckName), modify.set('cards', newCards)
    );
  }


  /**
   * Update a deck with new cards
   */
  static addDeck() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection = db.collection(COLLECTION_NAME);
    int countCollection = 0;
    await collection.count().then((data) {
      countCollection = data;
    });
    String deckName = "Deck ${countCollection + 1}";

    collection.insertOne({
      "highscore": 0.0,
      "attempts": 0,
      "name": deckName,
      "cards": [],
    });
  }
}