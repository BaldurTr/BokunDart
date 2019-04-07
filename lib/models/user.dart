import 'package:firebase_database/firebase_database.dart';
import 'package:login_demo/models/high_score.dart';
import 'package:login_demo/models/match.dart';

class User {
  User(this._userName, this._email, this._photoUrl,
      this._gameHistory, this._highScores, this._monthlyElo);

  User.fromSnapshot(DataSnapshot snapshot) {
    _userName = snapshot.value['username'];
    _email = snapshot.value['email'];
    _photoUrl = snapshot.value['photoURL'];
    _gameHistory = createMatchList(snapshot.value['scoreHistory']);
    _monthlyElo = createMonthlyMatchMap(snapshot.value['monthlyElo']);
    _highScores = createHighScoreList(snapshot.value['highestScore']);
  }

  User.map(dynamic obj) {
    _userName = obj['username'];
    _email = obj['email'];
    _photoUrl = obj['photoURL'];
    _gameHistory = createMatchList(obj['scoreHistory']);
    _monthlyElo = createMonthlyMatchMap(obj['monthlyElo']);
    _highScores = createHighScoreList(obj['highestScore']);
  }

  List<HighScore> createHighScoreList(Map<String, Object> data) {
    final List<HighScore> scores = [];
    data.values.forEach((Object game) => scores.add(HighScore.fromJson(game)));
    return scores;
  }

  List<Match> createMatchList(Map<String, Object> data) {
    final List<Match> matches = [];
    data.values.forEach((Object game) => matches.add(Match.fromJson(game)));
    return matches;
  }

  Map<String, List<Match>> createMonthlyMatchMap(Map<String, Map<String, Map<String, Object>>> data) {
    final Map<String, List<Match>> matches = {};
    data.forEach((String k, Map<String, Map<String, Object>> v) =>
        fillMonthlyMatchMap(k, matches, v));
    return matches;
  }

  void fillMonthlyMatchMap(String monthKey,
      Map<String, List<Match>> matches,
      Map<String, Map<String, Object>> monthlyMatches) {

      matches[monthKey] = createMatchList(monthlyMatches);
  }

  String _userName;
  String _email;
  String _photoUrl;
  Map<String, List<Match>> _monthlyElo;
  List<Match> _gameHistory;
  List<HighScore> _highScores;

  String get userName => _userName;
  String get email => _email;
  String get photoUrl => _photoUrl;
  Map<String, List<Match>> get monthlyElo => _monthlyElo;
  List<Match> get gameHistory => _gameHistory;
  List<HighScore> get highScores => _highScores;
}
