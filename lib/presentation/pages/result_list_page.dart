import 'package:flutter/material.dart';

import 'package:short_path/presentation/widgets/result_list_widget.dart';

class ResultListPage extends StatefulWidget {

  const ResultListPage({Key? key}) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Short Path Result List Page'),
        ),
        body: const SafeArea(
          child: Center(
              child: ResultListWidget(),
          ),
        )
    );
  }
}
