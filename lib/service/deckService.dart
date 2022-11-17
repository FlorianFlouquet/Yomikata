import 'package:flutter/cupertino.dart';

import '../mongoDb.dart';
import '../types/deckType.dart';

class DeckService {
  static getDeck() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await MongoDatabase.connect();
  }

  static updateDeck(String deckName, DeckType updatedDeck) async {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.save(deckName, updatedDeck);
  }
}