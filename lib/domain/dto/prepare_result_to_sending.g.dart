// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_result_to_sending.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareResultToSending _$PrepareResultToSendingFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'result'],
  );
  return PrepareResultToSending(
    id: json['id'] as String,
    result: ResultToSending.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PrepareResultToSendingToJson(
        PrepareResultToSending instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result.toJson(),
    };
