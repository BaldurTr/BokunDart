// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'high_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighScore _$HighScoreFromJson(Map<String, dynamic> json) {
  return HighScore(
      json['against'] as String,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['score'] as int);
}

Map<String, dynamic> _$HighScoreToJson(HighScore instance) => <String, dynamic>{
      'against': instance.opponentId,
      'date': instance.date?.toIso8601String(),
      'score': instance.score
    };
