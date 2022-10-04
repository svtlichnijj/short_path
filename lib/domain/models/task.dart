import 'dart:math';

import 'package:short_path/domain/dto/point_dto.dart';
import 'package:short_path/domain/models/field.dart';

class Task {
  final String id;
  final Field field;
  final PointDto start;
  final PointDto end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      field: Field.fromJson({'rowsColumns': {Field.jsonFieldName: json['field']}}),
      start: PointDto.fromJson(json['start']),
      end: PointDto.fromJson(json['end']),
    );
  }

  int getMinSteps() {
    return max((start.x - end.x).abs(), (start.y - end.y).abs());
  }
}