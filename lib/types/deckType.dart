import 'package:yomikata/types/cardType.dart';

class DeckType {
  final String _name;
  final double _highscore;
  final int _attempts;
  final List<CardType> _cards;

  String get name => _name;
  double get highscore => _highscore;
  int get attempts => _attempts;
  List<CardType> get cards => _cards;

  const DeckType(this._name, this._highscore, this._attempts, this._cards);

  @override
  String toString() {
    return 'DeckType{_name: $_name, _highscore: $_highscore, _attempts: $_attempts, _cards: $_cards}';
  }
}