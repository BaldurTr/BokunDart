// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartMatch _$MatchFromJson(Map<String, dynamic> json) {
  return DartMatch(
      json['against'] as String,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['elo'] as int)
    ..trumped = json['trumped'] as bool;
}

Map<String, dynamic> _$MatchToJson(DartMatch instance) => <String, dynamic>{
      'against': instance.opponentId,
      'date': instance.date?.toIso8601String(),
      'elo': instance.finalElo,
      'trumped': instance.trumped
    };
