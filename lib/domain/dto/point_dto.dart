import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/domain/enums/point_states.dart';

part 'point_dto.g.dart';

@JsonSerializable()
class PointDto {
  @JsonKey(required: true)
  final int x;

  @JsonKey(required: true)
  final int y;

  @JsonKey(defaultValue: PointStates.passing)
  PointStates state = PointStates.passing;

  PointDto({
    required this.x,
    required this.y,
    this.state = PointStates.passing,
  });

  factory PointDto.fromJson(Map<String, dynamic> json) => _$PointDtoFromJson(json);
  // factory PointDto.fromJson(Map<String, dynamic> json) {
  //   print('PointDto.fromJson');
  //   return PointDto(
  //     x: json['x'],
  //     y: json['y'],
  //   );
  // }
  // PointDto.fromJson(Map<String, dynamic> json)
  //     : x = json['x'],
  //       y = json['y'];

  Map<String, dynamic> toJson() => _$PointDtoToJson(this);
  // Map<String, dynamic> toJson() {
  //   print('PointDto.toJson');
  //   return {
  //     'x': x,
  //     'y': y,
  //   };
  // Map toJson(PointDto pointDto) => {
  //       'x': pointDto.x,
  //       'y': pointDto.y,
  //     };
  // }

  Map<String, int> coordinateOnly() => { 'x': x, 'y': y };

  String toPath() => '(' + x.toString() + ',' + y.toString() + ')';
  // String toPath() {
  //   return '(' + x.toString() + ',' + y.toString() + ')';
  // }

  bool isEqual(PointDto pointIn) => x == pointIn.x && y == pointIn.y && state == pointIn.state;
  // bool isEqual(PointDto pointIn) {
  //   return x == pointIn.x && y == pointIn.y;
  // }
}
