class DeckType {
  final String _name;
  final double _highscore;
  final int _attempts;

  String get name => _name;
  double get highscore => _highscore;
  int get attempts => _attempts;

  const DeckType(this._name, this._highscore, this._attempts);
}