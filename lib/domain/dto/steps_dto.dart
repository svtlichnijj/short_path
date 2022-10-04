import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/point_dto.dart';

part 'steps_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class StepsDto {
  @JsonKey(required: true)
  Set<PointDto> points;

  StepsDto(this.points);

  factory StepsDto.fromJson(Map<String, dynamic> json) => _$StepsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StepsDtoToJson(this);

  List<Map<String, int>> toCoordinate() {
    return points.map((e) => e.coordinateOnly()).toList();
  }

  String toResultToSending() {
    return points.map((e) => e.toPath()).reduce((value, pathPoint) => value + '->' + pathPoint);
  }
}