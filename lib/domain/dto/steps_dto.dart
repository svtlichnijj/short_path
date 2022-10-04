import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/point_dto.dart';

part 'steps_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class StepsDto {
  @JsonKey(required: true)
  // List<PointDto> points;
  Set<PointDto> points;

  StepsDto(this.points);

  factory StepsDto.fromJson(Map<String, dynamic> json) => _$StepsDtoFromJson(json);
  // factory StepsDto.fromJson(Map<String, dynamic> json) => StepsDto(
  //   points: (json['points'] as List<dynamic>)
  //       .map((e) => PointDto.fromJson(e as Map<String, dynamic>))
  //       .toSet(),
  // );

  Map<String, dynamic> toJson() => _$StepsDtoToJson(this);
  // Map<String, dynamic> toJson(StepsDto instance) => <String, dynamic>{
  //   'points': instance.points.map((e) => e.toJson()).toList(),
  // };
  /*
  Parent _$ParentFromJson(Map<String, dynamic> json) {
    return Parent(
      name: json['name'] as String,
      age: json['age'] as int,
      children: (json['children'] as List)
          ?.map(
              (e) => e == null ? null : Child.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      job: json['job'] == null
          ? null
          : Job.fromJson(json['job'] as Map<String, dynamic>),
    )..id = json['id'] as int;
  }
   */

  // Map<String, dynamic> toJson(StepsDto stepsDto) => <String, dynamic> {
  // Map<String, dynamic> toJson(StepsDto stepsDto) {
  // Map<String, dynamic> toJson() {
  //   print('stepsDto');
  //   // final val = <String, dynamic>{};
  //   //
  //   // void writeNotNull(String key, dynamic value) {
  //   //   if (value != null) {
  //   //     val[key] = value;
  //   //   }
  //   // }
  //   //
  //   // writeNotNull('points', stepsDto.points);
  //   // print(val);
  //   // return val;
  //   return {
  //     // 'points': {},
  //     // 'points': {stepsDto.points},
  //     'points': points.toList(),
  //     'points': points,
      // 'points': stepsDto,
      // 'points': stepsDto.points,
    // };
  // }
  List<Map<String, int>> toCoordinate() {
    return points.map((e) => e.coordinateOnly()).toList();
  }

  String toResultToSending() {
    return points.map((e) => e.toPath()).reduce((value, pathPoint) => value + '->' + pathPoint);
  }
}