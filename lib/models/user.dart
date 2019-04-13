import 'package:firebase_database/firebase_database.dart';
import 'package:login_demo/models/high_score.dart';
import 'package:login_demo/models/match.dart';

class User {
  User(this._userName, this._email, this._photoUrl,
      this._gameHistory, this._highScores, this._monthlyElo);

  User.fromSnapshot(DataSnapshot snapshot) {
    final snap_data = Map<String, dynamic>.from(snapshot.value);

    _userName = snap_data['username'];
    _email = snap_data['email'];
    _photoUrl = snap_data['photoURL'];
    _gameHistory = createMatchList(snap_data['scoreHistory']);
    _monthlyElo = createMonthlyMatchMap(snap_data['monthlyElo']);
    _highScores = createHighScoreList(snap_data['highestScore']);
  }

  List<HighScore> createHighScoreList(List<dynamic> data) {
    final List<HighScore> scores = [];
    for (var score in data) {
      final Map<String, dynamic> g = Map<String, dynamic>.from(score);
      scores.add(HighScore.fromJson(g));
    }
    return scores;
  }

  List<DartMatch> createMatchList(List<dynamic> data) {
    final List<DartMatch> matches = [];
    for (var game in data) {
      final Map<String, dynamic> g = Map<String, dynamic>.from(game);
      matches.add(DartMatch.fromJson(g));
    }
    return matches;
  }

  Map<String, List<DartMatch>> createMonthlyMatchMap(Map<dynamic, dynamic> data) {
    final Map<String, List<DartMatch>> matches = {};

    for (var month in data.keys) {
      final List<dynamic> monthlyGames = data[month];
      matches[month] = [];
      for (var game in monthlyGames) {
        final Map<String, dynamic> g = Map<String, dynamic>.from(game);
        matches[month].add(DartMatch.fromJson(g));
      }
    }

    for (List<DartMatch> gameList in matches.values) {
      gameList.sort((DartMatch a, DartMatch b) {
        return a.date.compareTo(b.date);
      });
    }
    return matches;
  }

  String _userName;
  String _email;
  String _photoUrl;
  Map<String, List<DartMatch>> _monthlyElo;
  List<DartMatch> _gameHistory;
  List<HighScore> _highScores;

  String get userName => _userName;
  String get email => _email;
  String get photoUrl => _photoUrl;
  Map<String, List<DartMatch>> get monthlyElo => _monthlyElo;
  List<DartMatch> get gameHistory => _gameHistory;
  List<HighScore> get highScores => _highScores;
  DartMatch get lastEloMatch => _monthlyElo['${DateTime.now().year}-${DateTime.now().month - 1}'].last;
}
