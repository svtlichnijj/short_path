import 'dart:ui';

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
  // StepsDto steps = StepsDto(points: []);
  StepsDto steps = StepsDto({});

  @JsonKey(required: true)
  final Field field;

  FieldPath(this.field);

  factory FieldPath.fromJson(Map<String, dynamic> json) => _$FieldPathFromJson(json);

  Map<String, dynamic> toJson() => _$FieldPathToJson(this);
  // Path.fromJson(Map<String, dynamic> json)
  //     : steps = json['steps'],
  //       field = json['field'];

  // static Map toJson(Path path) => {
  //       'steps': path.steps,
  //       'field': path.field,
  //     };
  // Map toJson() {
  //   print('Path toJson');
  //   return {
  //       // 'steps': steps,
  //       'field': field,
  //     };
  //   }

  get points {
    // print('steps.points');
    // print(steps.points);
    return steps.points;
  }

  bool addPoint(PointDto point, {bool isPassingOnly = true}) {
    try {
      PointDto pointToAdd = field.rowsColumns[point.y][point.x];

      if (!(isPassingOnly && pointToAdd.state != PointStates.passing)) {
        // if (steps.points.contains(pointToAdd)) {
        //   return false;
        // }
        // steps.points.add(pointToAdd);
        // return true;
        // OR If steps.points is Set
        return steps.points.add(pointToAdd);
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  bool addPointByXY(int xIn, int yIn, {bool isPassingOnlyIn = true}) {
    return addPoint(PointDto(x: xIn, y: yIn), isPassingOnly: isPassingOnlyIn);
  }

  Color getBackgroundColor(PointDto point) {
    PointColorTypes pointColorType = PointColorTypes.empty;

    if (point.state == PointStates.impassable) {
      pointColorType = PointColorTypes.blocked;
    } else {
      // print('point');
      // print(point.toJson());
      // print('steps.points');
      // print(jsonEncode(steps.points));
      // print(json.encode(steps.points));
      int stepsPointsIndex = steps.points.toList().indexWhere((element) => element.isEqual(point));
      // // int stepsPointsIndex = steps.points.toList().indexOf(point);
      // print('stepsPointsIndex');
      // print(stepsPointsIndex);

      if (stepsPointsIndex != -1) {
        pointColorType = PointColorTypes.shortestPath;
        int stepsPointsLastIndex = steps.points.length - 1;
        // print('stepsPointsLastIndex');
        // print(stepsPointsLastIndex);

        if (stepsPointsIndex == 0) {
          pointColorType = PointColorTypes.starting;
        } else if (stepsPointsIndex == stepsPointsLastIndex) {
          pointColorType = PointColorTypes.ending;
        }
      }
    }
    
    return PointColor.get(pointColorType);
  }
}
