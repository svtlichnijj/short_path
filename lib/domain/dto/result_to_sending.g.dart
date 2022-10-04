// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_to_sending.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultToSending _$ResultToSendingFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['steps', 'path'],
  );
  return ResultToSending(
    steps: ResultToSending._fromResultToSendingStepsJson(
        json['steps'] as List<Map<String, int>>),
    path: json['path'] as String,
  );
}

Map<String, dynamic> _$ResultToSendingToJson(ResultToSending instance) =>
    <String, dynamic>{
      'steps': ResultToSending._toResultToSendingStepsJson(instance.steps),
      'path': instance.path,
    };
