import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/steps_dto.dart';

part 'result_to_sending.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultToSending {
  @JsonKey(required: true, fromJson: _fromResultToSendingStepsJson, toJson: _toResultToSendingStepsJson)
  final StepsDto steps;

  @JsonKey(required: true)
  final String path;
  // String _path;
  // @JsonKey(ignore: true)
  // Path path;

  // ResultToSending(Path path)
  //     : _steps = path.steps,
  //       _path = path.toResultToSending();
  ResultToSending({
    required this.steps,
    required this.path
  });

  factory ResultToSending.fromJson(Map<String, dynamic> json) => _$ResultToSendingFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToSendingToJson(this);

  // ResultToSending.fromJson(Map<String, dynamic> json)
  //     : _steps = json['steps'],
  //       _path = json['path'];
  static StepsDto _fromResultToSendingStepsJson(List<Map<String, int>> jsonIn) {
  // static StepsDto _fromResultToSendingStepsJson(Map<String, dynamic> jsonIn) {
  //   print('jsonIn G');
  //   print(jsonIn);
  //   print('jsonIn[0] G');
  //   print(jsonIn[0]);
  //   StepsDto steps = jsonIn[0]['steps'];
    return StepsDto.fromJson(jsonIn[0]);
    // return steps;
  }

  static List<Map<String, int>> _toResultToSendingStepsJson(StepsDto data) {
    return data.toCoordinate();
  }
  // Map<String, dynamic> toJson() => {
  //       'steps': _steps.toCoordinate(),
  //       'path': _path,
  //     };
}
