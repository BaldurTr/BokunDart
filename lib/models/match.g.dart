// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) {
  return Match(
      json['against'] as String,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['elo'] as int)
    ..trumped = json['trumped'] == null ? false : json['trumped'] as bool;
}

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'against': instance.opponentId,
      'date': instance.date?.toIso8601String(),
      'elo': instance.finalElo,
      'trumped': instance.trumped
    };
