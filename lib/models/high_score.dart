import 'package:json_annotation/json_annotation.dart';

part 'high_score.g.dart';

@JsonSerializable()
class HighScore {
  HighScore(this.opponentId, this.date, this.score);

  factory HighScore.fromJson(Map<String, dynamic> json) =>
      _$HighScoreFromJson(json);

  Map<String, dynamic> toJson() => _$HighScoreToJson(this);

  @JsonKey(name: 'against')
  String opponentId;
  DateTime date;
  int score;
}