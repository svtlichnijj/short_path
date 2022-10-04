import 'package:flutter/material.dart';

import 'package:short_path/data/api/path_finding_api.dart';

class ValidateUrlService {
  TextEditingController urlTextEditing = TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');
  ValueNotifier<bool> isStartCountingProcess = ValueNotifier(false);

  void isEmptyField() {
    isStartCountingProcess.value = urlTextEditing.text.isNotEmpty;
  }

  String? getErrorText() {
    String? enteredUrl = urlTextEditing.text;

    if (enteredUrl.isEmpty) {
      return 'Can\'t be empty';
    }

    try {
      Uri uri = Uri.parse(enteredUrl);

      if (uri.host != PathFinderApi.host) {
        return 'Wrong host';
      }

      if (!uri.isScheme(PathFinderApi.scheme)) {
        return 'Wrong schema';
      }

      if (uri.path != PathFinderApi.path) {
        return 'Wrong path';
      }

      if (!uri.isAbsolute) {
        return 'Not absolute';
      }

    } on FormatException {
      return 'Format error!';
    }

    return null;
  }
}
