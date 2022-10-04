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
    // print('json');
    // print(json);
    // print("json.runtimeType");
    // print(json.runtimeType);
    // print('field');
    // print(json['field']);
    // print("json['field'].runtimeType");
    // print(json['field'].runtimeType);
    // print(json['field'] as Map<String, dynamic>);
    return Task(
      id: json['id'],
      // field: Field.fromJson(
      //   // { for (var r in json['field']) 'rowsColumns' : { for (var c in r) 'c': c} }
      //   { for (var e in json['field']) 'rowsColumns' : {'0': e} }
      //   // Map.fromIterable(json['field'], key: (e) => 'rowsColumns', value: (e) => {0: e},)
      // ),
      field: Field.fromJson({'rowsColumns': {Field.jsonFieldName: json['field']}}),
      // field: Field.fromJson(json['field'] as Map<String, dynamic>),
      // field: Field.fromJson(json),
      // field: Field.fromJson(json),
      // field: Field.fromJson({'rowsColumns': {'field': json['field']}}),
      start: PointDto.fromJson(json['start']),
      end: PointDto.fromJson(json['end']),
    );
  }

  int getMinSteps() {
    return max((start.x - end.x).abs(), (start.y - end.y).abs());
  }
}