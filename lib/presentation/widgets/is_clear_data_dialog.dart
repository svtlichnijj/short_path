import 'package:flutter/material.dart';

class IsClearDataDialog extends StatelessWidget {
  final Function(bool) callback;

  const IsClearDataDialog({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Clear saved local data'),
      content: const Text('Are you sure you want to clear saved local data?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            callback(false);
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            callback(true);
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
