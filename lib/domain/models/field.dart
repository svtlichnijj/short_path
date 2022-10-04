import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/point_dto.dart';
import 'package:short_path/domain/enums/point_states.dart';

part 'field.g.dart';

@JsonSerializable()
class Field {
  @JsonKey(ignore: true)
  static const String jsonFieldName = 'field';

  @JsonKey(
    fromJson: _fromTaskResponseJson, toJson: _toTaskResponseJson,
  )
  List<List<PointDto>> rowsColumns;

  Field(this.rowsColumns);

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);

  static List<List<PointDto>> _fromTaskResponseJson(Map<String, dynamic> jsonIn) {
    List<List<PointDto>> data = [];
    List<dynamic> json = jsonIn[jsonFieldName];

    for (int r = 0; r < json.length; r++) {
      String row = json[r];
      List<PointDto> points = [];

      for (int c = 0; c < row.length; c++) {
        points.add(PointDto(x: c, y: r, state: row[c] == '.' ? PointStates.passing : PointStates.impassable));
      }

      data.add(points);
    }

    return data;
  }

  static Map<String, dynamic> _toTaskResponseJson(List<List<PointDto>> data) {
    Map<String, dynamic> json = {'field': []};

    for (var rows in data) {
      String row = '';

      for (PointDto pointDto in rows) {
        row += pointDto.state == PointStates.passing ? '.' : 'X';
      }

      (json['field']).add(row);
    }

    return json;
  }
}
