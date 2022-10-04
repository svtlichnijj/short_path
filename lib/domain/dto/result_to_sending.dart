import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/steps_dto.dart';

part 'result_to_sending.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultToSending {
  @JsonKey(required: true, fromJson: _fromResultToSendingStepsJson, toJson: _toResultToSendingStepsJson)
  final StepsDto steps;

  @JsonKey(required: true)
  final String path;

  ResultToSending({
    required this.steps,
    required this.path
  });

  factory ResultToSending.fromJson(Map<String, dynamic> json) => _$ResultToSendingFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToSendingToJson(this);

  static StepsDto _fromResultToSendingStepsJson(List<Map<String, int>> jsonIn) {
    return StepsDto.fromJson(jsonIn[0]);
  }

  static List<Map<String, int>> _toResultToSendingStepsJson(StepsDto data) {
    return data.toCoordinate();
  }
}
