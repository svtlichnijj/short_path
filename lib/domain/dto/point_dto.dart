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
  PointStates state;

  PointDto({
    required this.x,
    required this.y,
    this.state = PointStates.passing,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PointDto &&
              runtimeType == other.runtimeType &&
              x == other.x &&
              y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  factory PointDto.fromJson(Map<String, dynamic> json) => _$PointDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointDtoToJson(this);

  Map<String, int> coordinateOnly() => { 'x': x, 'y': y };

  String toPath() => '(' + x.toString() + ',' + y.toString() + ')';

  bool isEqual(PointDto pointIn) => x == pointIn.x && y == pointIn.y && state == pointIn.state;
}
