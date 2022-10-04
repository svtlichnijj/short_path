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
    // readValue: _readData
    // // OR
    // name: 'field'
  )
  List<List<PointDto>> rowsColumns;

  Field(this.rowsColumns);

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);

  // // static List<List<PointDto>> _readData(Map<dynamic, dynamic> jsonIn, String nameIn) => nameIn;
  // static Map<String, dynamic> _readData(Map<dynamic, dynamic> jsonIn, String nameIn) {
  // // static Object _readData(Map<dynamic, dynamic> jsonIn, String nameIn) {
  //   print('jsonIn');
  //   print(jsonIn);
  //   print('nameIn');
  //   print(nameIn);
  //   // return { for (var e in jsonIn['field']) 'field' : e};
  //   // return { for (var i; i < jsonIn['field'].length; i++) 'field' : { i: jsonIn['field'][i] } };
  //   // return { for (var r in jsonIn['field']) 'field' : { for (var i; i < r.length; i++) i: r } };
  //   // return Map.fromIterable(jsonIn['field'], key: (e) => 'field', value: (e) => {0: e},);
  //   // return {'field': jsonIn['field']};
  //
  //   Map<String, dynamic> out = {_jsonFieldName: {}};
  //   // for (var i = 0; i <= jsonIn['field'].length - 1; i++) {out['field'].add(i: jsonIn['field'][i] ); };
  //   for (var i = 0; i <= jsonIn[_jsonFieldName].length - 1; i++) {
  //     out[_jsonFieldName][i] = jsonIn[_jsonFieldName][i];
  //   }
  //
  //   return out;
  // }

  static List<List<PointDto>> _fromTaskResponseJson(Map<String, dynamic> jsonIn) {
    // factory Field.fromJson(List<dynamic> json) {
    // factory Field.fromJson(List<String> json) {
    //   print('--fromTaskResponseJson--');
    //   print('-jsonIn-');
    //   print(jsonIn);
    List<dynamic> json = jsonIn[jsonFieldName];
    // Map<dynamic, dynamic> json = jsonIn[_jsonFieldName];
    // print('-json-');
    // print(json);
    // print(json.runtimeType);
    List<List<PointDto>> data = [];
    List<PointDto> points = [];

    for (int r = 0; r < json.length; r++) {
      String row = json[r];
      // print('row');
      // print(row);
      points = [];

      for (int c = 0; c < row.length; c++) {
        points.add(PointDto(x: c, y: r, state: row[c] == '.' ? PointStates.passing : PointStates.impassable));
      }

      data.add(points);
    }

    return data;
    // return Field(
    //   rowsColumns: data
    //   // data: arrayToData(json)
    // );
  }

  static Map<String, dynamic> _toTaskResponseJson(List<List<PointDto>> data) {
    // return {'field': ['.X.', '.X.', '...']};
    Map<String, dynamic> json = {'field': []};
    // print('toTaskResponseJson.data');
    // print(data);
    String row = '';

    for (var rows in data) {
      row = '';

      for (PointDto pointDto in rows) {
        row += pointDto.state == PointStates.passing ? '.' : 'X';
      }

      // print('row');
      // print(row);
      (json['field']).add(row);
      // print('json');
      // print(json);
    }

    return json;
    // return jsonDecode(data);
  }
// static Map toJson(Field field) => {
//   {
//     field
//   }
//   field.rowsColumns.forEach((element) {
//     element.forEach((element) { jsonEncode(element) })
//   }),
// };
/*
  static List<List<Point>> arrayToData(List<dynamic> rows) {
    List<List<Point>> data = [];
    List<Point> points = [];

    for (var r = 0; r < rows.length; r++) {
      String row = rows[r];
      print(row);
      points = [];

      for (var c = 0; c < row.length; c++) {
        points.add(Point(x: c, y: r, state: row[c] == '.' ? PointStates.passing : PointStates.impassable));
      }

      data.add(points);
    }

    return data;
  }
   */

// static List<Point> rowToPoints(String row, int rowIndex) {
// // static Map<Point, dynamic> rowToPoints(String row, int rowIndex) {
//   List<Point> points = [];
//   // Map<Point, dynamic> points = {};
//
//   for (int i = 0; i < row.length; i++) {
//     points.add(Point(x: i, y: rowIndex, state: row[1] == '.' ? PointStates.passing : PointStates.impassable));
//     // points.addAll({Point(x: i, y: rowIndex, state: row[1] == '.' ? PointStates.passing : PointStates.impassable): 1});
//   }
//
//   return points;
// }
}
