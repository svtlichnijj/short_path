import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/enums/point_color.dart';
import 'package:short_path/domain/dto/point_dto.dart';
import 'package:short_path/domain/enums/point_states.dart';
import 'package:short_path/domain/dto/steps_dto.dart';
import 'package:short_path/domain/models/field.dart';

part 'field_path.g.dart';

@JsonSerializable(explicitToJson: true)
class FieldPath {
  @JsonKey(required: true)
  StepsDto steps = StepsDto({});

  @JsonKey(required: true)
  final Field field;

  FieldPath(this.field);

  factory FieldPath.fromJson(Map<String, dynamic> json) => _$FieldPathFromJson(json);

  Map<String, dynamic> toJson() => _$FieldPathToJson(this);

  get points {
    return steps.points;
  }

  bool addPoint(PointDto point, {bool isPassingOnly = true}) {
    try {
      PointDto pointToAdd = field.rowsColumns[point.y][point.x];

      if (!(isPassingOnly && pointToAdd.state != PointStates.passing)) {
        return steps.points.add(pointToAdd);
      }

      return false;
    } catch (e) {
      // To exclude "RangeError (index): Invalid value: Not in inclusive range..."
      return false;
    }
  }

  bool addPointByXY(int xIn, int yIn, {bool isPassingOnlyIn = true}) {
    return addPoint(PointDto(x: xIn, y: yIn), isPassingOnly: isPassingOnlyIn);
  }

  PointColorTypes getPointColorType(PointDto point) {
    PointColorTypes pointColorType = PointColorTypes.empty;

    if (point.state == PointStates.impassable) {
      pointColorType = PointColorTypes.blocked;
    } else {
      int stepsPointsIndex = steps.points.toList().indexWhere((element) => element.isEqual(point));

      if (stepsPointsIndex != -1) {
        pointColorType = PointColorTypes.shortestPath;
        int stepsPointsLastIndex = steps.points.length - 1;

        if (stepsPointsIndex == 0) {
          pointColorType = PointColorTypes.starting;
        } else if (stepsPointsIndex == stepsPointsLastIndex) {
          pointColorType = PointColorTypes.ending;
        }
      }
    }
    
    return pointColorType;
  }
}
