import 'package:flutter/material.dart';

import 'package:short_path/navigation/navigation.dart';

void main() {
  // runApp(MyApp());
  runApp(const MyApp());
  /*
  runApp(
    MaterialApp(
      builder: (context, child) => SafeArea(child: Material(color: Colors.white, child: child)),
      home: const MyStatefulWidget(),
    ),
  );
   */
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('--MyApp');
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Navigation(),
    );
  }
}

/*
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var stream; // state variable

  @override
  void initState() {
    super.initState();
    stream = newStream(); // initial stream
  }

  Stream<String> newStream() {
    int i = 0;
    print('i');

    while (i < 10) {
      print('in');
      Future<void>.delayed(const Duration(seconds: 2));
      print('iin');
      i++;
      // Future<void>.delayed(const Duration(seconds: 2), Stream.value(i.toString()));
      Stream.value(i.toString());
      // return Stream.periodic(const Duration(seconds: 1), (i) => "$i");
    }

    print('end');
    return Stream.value('11');
  }

  @override
  Widget build(BuildContext context) {
    var streamBuilder = StreamBuilder(
        initialData: "0",
        stream: stream,
        builder: (context, snapshot) {
          return Text(snapshot.data.toString());
        });
    return MaterialApp(
        title: 'Trial',
        home: Scaffold(
            appBar: AppBar(title: Text('Stream builder')),
            body: Column(
              children: <Widget>[
                streamBuilder,
                FlatButton(
                    onPressed: () {
                      setState(() {
                        stream = newStream(); //refresh/reset the stream
                      });
                    },
                    child: Text("Reset"))
              ],
            )));
  }
}

 */
/*

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyStatefulWidgetState();

  // note: updated as context.ancestorStateOfType is now deprecated
  static MyStatefulWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyStatefulWidgetState>();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _string = "Not set yet";

  set string(String value) => setState(() => _string = value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_string),
        MyChildClass(callback: (val) => setState(() => _string = val))
      ],
    );
  }
}

typedef StringCallback = void Function(String val);

class MyChildClass extends StatelessWidget {
  final StringCallback callback;

  const MyChildClass({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
        // FlatButton(
          onPressed: () {
            callback("String from method 1");
          },
          child: Text("Method 1"),
        ),
        TextButton(
        // FlatButton(
          onPressed: () {
            MyStatefulWidget.of(context)?.string = "String from method 2";
          },
          child: Text("Method 2"),
        )
      ],
    );
  }
}
 */