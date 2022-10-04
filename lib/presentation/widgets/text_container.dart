import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final bool isTransparent;

  const TextContainer({Key? key, required this.text, this.isTransparent = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(isTransparent ? 0.0 : 1.0),
            fontSize: 18.0,
          ),
        ));
  }

  static getTextErrorList(var textError) {
    return <Widget>[
      const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(textError.toString(), style: TextStyle(background: Paint()..color = Colors.red))
      )
    ];
  }
}

class TextErrorContainer extends StatelessWidget {
  final String textError;
  const TextErrorContainer({Key? key, required this.textError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(textError, style: TextStyle(background: Paint()..color = Colors.red))
          )
        ],
      ),
    );
  }
}
