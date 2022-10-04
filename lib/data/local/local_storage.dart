import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:short_path/domain/models/field_path.dart';

class LocalStorage {
  static final String _storagePath = 'assets${path.separator}storage';

  static Future<File> _localFile({String fileName = 'paths'}) async {
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
    final file = await _localFile(fileName: fileName);
    file.writeAsStringSync(json.encode(data));
  }

  static dynamic getData({String fileName = 'paths'}) async {
    final file = await _localFile(fileName: fileName);
    var data = await file.readAsString();

    if (data.isEmpty) {
      return null;
    }

    return json.decode(data);
  }

  static void setPaths(Map<String, FieldPath> paths) async {
    setData(paths);
  }

  static Future<Map<String, FieldPath>?> getPaths() async {
    try {
      Map<String, FieldPath> fieldPaths = {};
      dynamic fieldPathsSource = await getData();

      if (fieldPathsSource == null) {
        return null;
      }

      fieldPathsSource.forEach((k, v) => fieldPaths.addAll({k as String: FieldPath.fromJson(v)}));

      return fieldPaths;
    } on FormatException {
      if (kDebugMode) {
        print('Format error in LocalStorage.getPaths()!');
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }

  static Future<FieldPath?> getPath(String pathId) async {
    Map? paths = await getPaths();

    if (paths!.containsKey(pathId)) {
      return paths[pathId];
    }

    return null;
  }
}