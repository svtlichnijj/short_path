import 'dart:convert';

import 'package:http/http.dart' as http;

class PathFinderApi {
  static const String host = 'flutter.webspark.dev';
  static const String scheme = 'https';
  static const String path = '/flutter/api';
  static const String apiUrl = scheme + '://' + host + path;
  /*
https://flutter.webspark.dev/api
   */

  static Future<List<dynamic>> getTasksData(String? validUrl) async {
    // print('validUrl');
    // print(validUrl);
    final response = await http.get(Uri.parse(validUrl ?? apiUrl));
    // print('response');
    // print(response);
    // print('getData(response)');
    // print(getData(response));

    return _getData(response);
  }

  static Future<List<dynamic>> setResults(Object? body) async {
    // print('setResults');
    // print('body.runtimeType');
    // print(body.runtimeType);
    // print('body');
    // print(body);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: body,
    );
    // print('response');
    // print(response);

    return _getData(response);
  }

  static dynamic _getData(http.Response response) {
    print('response.statusCode');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('response.body');
      print(response.body);
      Map responseBody = jsonDecode(response.body);
      print('responseBody');
      print(responseBody);

      if (responseBody['error'] == true) {
        return responseBody['message'];
      }

      // print('--getData 200--');
      // print('responseBody.runtimeType');
      // print(responseBody.runtimeType);
      // print('responseBody');
      // print(responseBody);
      // print('responseBody[data].runtimeType');
      // print(responseBody['data'].runtimeType);
      // print('responseBody[data]');
      // print(responseBody['data']);
      return responseBody['data'];
    } else {
      // print('--getData !200--');
      // print('response.statusCode');
      // print(response.statusCode);
      // print('response.body');
      // print(response.body);
      // var responseBody = jsonDecode(response.body);
      // print('responseBody.runtimeType');
      // print(responseBody.runtimeType);
      // print('responseBody');
      // print(responseBody);
      throw Exception('Failed to get tasks data.\nResponse:\n' + jsonDecode(response.body).toString());
    }
  }
}