class CardType {
  final String _kanji;
  final String _pronun;

  String get pronun => _pronun;
  String get kanji => _kanji;

  const CardType(this._kanji, this._pronun);
}