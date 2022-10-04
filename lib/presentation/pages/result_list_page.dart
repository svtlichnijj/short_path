import 'package:flutter/material.dart';
import 'package:short_path/presentation/widgets/result_list_widget.dart';

class ResultListPage extends StatefulWidget {
  // final Future<List<PrepareResultToSending>> prepareResultsToSending;

  const ResultListPage({ Key? key/*, required this.prepareResultsToSending*/ }) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  @override
  Widget build(BuildContext context) {
    // final args = PrepareResultToSending.listFromPathsPoints(null);
    // final args = ModalRoute.of(context)!.settings.arguments as Future<List<PrepareResultToSending>>;
    // print('args 19');
    // print(args);
    // print('widget.prepareResultsToSending');
    // print(widget.prepareResultsToSending);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Short Path Result List Page'),
        ),
        body: const SafeArea(
          child: Center(
              child: /*FutureBuilder(builder: builder)*/ ResultListWidget(
                  // prepareResultsToSending: args
                  // prepareResultsToSending: widget.prepareResultsToSending
              )
          ),
        )
    );
  }
}
