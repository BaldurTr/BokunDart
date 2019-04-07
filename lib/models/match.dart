import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  Match(this.opponentId, this.date, this.finalElo);

  factory Match.fromJson(Map<String, dynamic> json) =>
      _$MatchFromJson(json);

  @JsonKey(name: 'against')
  String opponentId;
  DateTime date;
  @JsonKey(name: 'elo')
  int finalElo;
  bool trumped;

  Map<String, dynamic> toJson() => _$MatchToJson(this);
}