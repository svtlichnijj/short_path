import 'package:short_path/domain/dto/steps_dto.dart';

class ResultToSending {
  StepsDto steps;

  ResultToSending(this.steps);

  factory ResultToSending.fromJson(Map<String, dynamic> jsonIn) =>
      ResultToSending(StepsDto.fromJson({'points': jsonIn['steps']}));

  Map<String, dynamic> toJson() => {
    'steps': steps.toCoordinate(),
    'path': steps.toResultToSending(),
  };
}