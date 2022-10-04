import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PathFinderApi {
  static const String host = 'flutter.webspark.dev';
  static const String scheme = 'https';
  static const String path = '/flutter/api';
  static const String apiUrl = scheme + '://' + host + path;  // https://flutter.webspark.dev/api

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

      return responseBody['data'];
    } else {
      throw Exception('Failed to get tasks data.\nResponse:\n' + jsonDecode(response.body).toString());
    }
  }
}