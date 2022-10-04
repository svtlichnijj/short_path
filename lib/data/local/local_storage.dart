import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:short_path/domain/models/field_path.dart';

class LocalStorage {
  static final String _storagePath = 'assets${path.separator}storage';
  // static String get _storagePath {
  //   return 'assets${path.separator}storage';
  // }

  static Future<File> _localFile({String fileName = 'paths'}) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final directory = await getApplicationSupportDirectory();
    final String directoryPath = path.join((await getTemporaryDirectory()).path, _storagePath);
    createFolder(directoryPath);

    final String filePath = directoryPath + path.separator + fileName + '.json';
    File(filePath).createSync(recursive: true);

    return File(filePath);
  }

  static void createFolder(String directoryIn) async {
    if (await Directory(directoryIn).exists() != true) {
      Directory(directoryIn).createSync(recursive: true);
    }
  }

  static void deleteFolder({String? directoryIn}) async {
    directoryIn = directoryIn ?? path.join((await getTemporaryDirectory()).path, _storagePath);

    if (await Directory(directoryIn).exists() == true) {
      Directory(directoryIn).deleteSync(recursive: true);
    }
  }

  static void setData(dynamic data, {String fileName = 'paths'}) async {
  // static void setData(dynamic data, {String fileName = 'paths', FileMode mode = FileMode.write}) async {
  // static Future<File> setData(dynamic data, {String fileName = 'paths'}) async {
  //   print('data');
  //   print(data);
    final file = await _localFile(fileName: fileName);
    file.writeAsStringSync(json.encode(data));
    // return file.writeAsStringSync(json.encode(data/*.toJson()*/), mode: mode);
  }

  static getData({String fileName = 'paths'}) async {
    final file = await _localFile(fileName: fileName);

    return json.decode(await file.readAsString());
  }

  static void setPaths(Map<String, FieldPath> paths) async {
    setData(paths);
  }

  static Future<Map<String, FieldPath>?> getPaths() async {
    try {
      // final file = await _localFile();
      // var fieldPathsSource = json.decode(await file.readAsString());
      // OR
      var fieldPathsSource = await getData();
      // var fieldPathsSource = json.decode(fieldPathsString);
      // var fieldPathsSource = json.decode('{"7d785c38-cd54-4a98-ab57-44e50ae646c1":{"steps":{"points":[{"x":2,"y":1,"state":true},{"x":1,"y":2,"state":true},{"x":0,"y":2,"state":true}]},"field":{"rowsColumns":{"field":[".X.",".X.","..."]}}},"88746d24-bf68-4dea-a6b6-4a8fefb47eb9":{"steps":{"points":[{"x":0,"y":3,"state":true},{"x":1,"y":2,"state":true},{"x":2,"y":1,"state":true},{"x":3,"y":0,"state":true}]},"field":{"rowsColumns":{"field":["XXX.","X..X","X..X",".XXX"]}}}}');
      // print('fieldPathsSource');
      // print(fieldPathsSource);
      // print('fieldPathsSource.runtimeType');
      // print(fieldPathsSource.runtimeType);
      // Map<String, FieldPath> fieldPaths4 = FieldPath.fromJson(fieldPathsSource);
      Map<String, FieldPath> fieldPaths = {};
      // Map<String, FieldPath> fieldPaths = Map.castFrom(fieldPathsSource);
      // Map<String, FieldPath> fieldPaths = fieldPathsSource.map((k, v) {
      // var fieldPaths = fieldPathsSource.map((k, v) {
      fieldPathsSource.forEach((k, v) => fieldPaths.addAll({k as String : FieldPath.fromJson(v)}));
      /*
      Map<String, FieldPath> fieldPaths = fieldPathsSource.map((k, v) {
        print('k');
        print(k);
        print('k.runtimeType');
        print(k.runtimeType);
        print('v');
        print(v);
        print('v.runtimeType');
        print(v.runtimeType);
        print('FieldPath.fromJson(v)');
        print(FieldPath.fromJson(v));
        print('FieldPath.fromJson(v).runtimeType');
        print(FieldPath.fromJson(v).runtimeType);
        return MapEntry(k as String, FieldPath.fromJson(v));
      });
       */
      // print('fieldPaths');
      // print(fieldPaths);
      // print('fieldPaths.runtimeType');
      // print(fieldPaths.runtimeType);
      return fieldPaths;
    } catch (e) {
      return null;
    }
  }

  static Future<FieldPath?> getPath(String pathId) async {
    try {
      Map? paths = await getPaths();
      // print('path get');
      // print(paths);

      if (paths!.containsKey(pathId)) {
        return paths[pathId];
        // return FieldPath.fromJson(paths[pathId]);
      }
    } catch (e) {
      // print('catch error getPath');
      // print(e);
      return null;
    }

    // print('return null getPath');
    return null;
  }
}