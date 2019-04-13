import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
class DartMatch {
  DartMatch(this.opponentId, this.date, this.finalElo);

  factory DartMatch.fromJson(Map<String, dynamic> json) =>
      _$MatchFromJson(json);

  Map<String, dynamic> toJson() => _$MatchToJson(this);

  @JsonKey(name: 'against')
  String opponentId;
  DateTime date;
  @JsonKey(name: 'elo')
  int finalElo;
  bool trumped;

  int get getFinalElo => finalElo;
}