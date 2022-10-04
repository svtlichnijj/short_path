// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointDto _$PointDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['x', 'y'],
  );
  return PointDto(
    x: json['x'] as int,
    y: json['y'] as int,
    state: $enumDecodeNullable(_$PointStatesEnumMap, json['state']) ??
        PointStates.passing,
  );
}

Map<String, dynamic> _$PointDtoToJson(PointDto instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'state': _$PointStatesEnumMap[instance.state]!,
    };

const _$PointStatesEnumMap = {
  PointStates.passing: 'passing',
  PointStates.impassable: 'impassable',
};
