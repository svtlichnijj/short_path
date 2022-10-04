// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldPath _$FieldPathFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['steps', 'field'],
  );
  return FieldPath(
    Field.fromJson(json['field'] as Map<String, dynamic>),
  )..steps = StepsDto.fromJson(json['steps'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FieldPathToJson(FieldPath instance) => <String, dynamic>{
      'steps': instance.steps.toJson(),
      'field': instance.field.toJson(),
    };
