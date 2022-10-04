import 'package:flutter/material.dart';
import 'package:short_path/data/api/path_finding_api.dart';

class ValidateUrlService {
  TextEditingController urlTextEditing = TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');
  ValueNotifier<bool> isStartCountingProcess = ValueNotifier(false);

  void isEmptyField() {
    // print('isEmptyField: '+ isStartCountingProcess.value.toString());
    isStartCountingProcess.value = urlTextEditing.text.isNotEmpty;
  }

  String? getErrorText() {
    // print('isStartCountingProcess.value: ' + isStartCountingProcess.value.toString());
    // isEmptyField();
    // String? errorText;
    // print('getErrorText');
    String? enteredUrl = urlTextEditing.text;
    // print('enteredUrl: ' + enteredUrl.toString());

    if (enteredUrl.isEmpty) {
      // print('Can\'t be empty');
      return 'Can\'t be empty';
    }

    try {
      Uri uri = Uri.parse(enteredUrl);
      print('uri: ' + uri.toString());

      if (uri.host != PathFinderApi.host) {
        // print('Wrong host');
        return 'Wrong host';
      }

      if (!uri.isScheme(PathFinderApi.scheme)) {
        // print('Wrong schema');
        return 'Wrong schema';
      }

      if (uri.path != PathFinderApi.path) {
        // print('Wrong path');
        return 'Wrong path';
      }

      if (!uri.isAbsolute) {
        // print('Not absolute');
        return 'Not absolute';
      }

    } on FormatException {
      // print('Format error!');
      return 'Format error!';
    }

    return null;
  }
}
