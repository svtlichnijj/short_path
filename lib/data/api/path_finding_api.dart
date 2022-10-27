import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PathFinderApi {
  static const String host = 'flutter.webspark.dev';
  static const String scheme = 'https';
  static const String path = '/flutter/api';
  static const String apiUrl = scheme + '://' + host + path; // https://flutter.webspark.dev/api

  static Future<List<dynamic>> getTasksData(String? validUrl) async {
    final response = await http.get(Uri.parse(validUrl ?? apiUrl));

    return _getData(response);
  }

  static Future<List<dynamic>> setResults(Object? body) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: body,
    );

    // For test only
    // return [{'error': true, 'message': 'Not valid test ID', 'data': {}, 'correct': true}];
    return _getData(response);
  }

  static dynamic _getData(http.Response response) {
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('response.body');
        print(response.body);
      }

      Map responseBody = jsonDecode(response.body);

      if (responseBody['error'] == true) {
        return responseBody['message'];
      }

      /*
      // For test only
      return [
        {
          "id": "7d785c38-cd54-4a98-ab57-44e50ae646c1",
          "field": [
            "XX........X",
            "X.XXXXXXXX.",
            ".XX.....XX.",
            ".XX.XXXX.X.",
            ".X....XX.X.",
            ".XXXXX.X.X.",
            ".XX..X.X.X.",
            ".XX.XX.X.X.",
            ".XX...XX.X.",
            ".XXXXXXX.X.",
            "..X.....XX.",
            "XX.XXXXXXX."
          ],
          "start": {
            "x": 4,
            "y": 6
          },
          "end": {
            "x": 10,
            "y": 10
          }
        },
        {
          "id": "7d785c38-cd54-4a98-ab57-44e50ae646c2",
          "field": [
            ".......X",
            "XXXXXXX.",
            ".....XX.",
            ".XXXX.X.",
            "...XX.X.",
            "XXX.X.X.",
            "..X.X...",
            ".XX.X.X.",
            "...XX.X.",
            "XXXXX.X.",
            ".....XX."
          ],
          "start": {
            "x": 0, //7,
            "y": 0 //9
          },
          "end": {
            "x": 1,
            "y": 6
          }
        },
        {
          "id": "88746d24-bf68-4dea-a6b6-4a8fefb47eb9",
          "field": [
            "X....",
            ".XXX.",
            "X..XX",
            ".XXXX"
          ],
          "start": {
            "x": 0,
            "y": 3
          },
          "end": {
            "x": 4,
            "y": 1
          }
        }
      ];
       */
      return responseBody['data'];
    } else {
      throw Exception('Failed to get tasks data.\nResponse:\n' + jsonDecode(response.body).toString());
    }
  }
}