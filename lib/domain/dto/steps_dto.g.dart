// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepsDto _$StepsDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['points'],
  );
  return StepsDto(
    (json['points'] as List<dynamic>)
        .map((e) => PointDto.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$StepsDtoToJson(StepsDto instance) => <String, dynamic>{
      'points': instance.points.map((e) => e.toJson()).toList(),
    };
