import 'dart:async';

import 'package:flutter/material.dart';

import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
import 'package:short_path/presentation/widgets/is_clear_data_dialog.dart';
import 'package:short_path/presentation/widgets/result_list_widget.dart';

class ResultListPage extends StatefulWidget {

  const ResultListPage({Key? key}) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  bool _isCanClearLocalData = false;
  late Stream<List<PrepareResultToSending>> _prepareResultsToSending;
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    initStreamWithListener();
  }

  void initStreamWithListener() async {
    _prepareResultsToSending = PrepareResultToSending.listFromLocalPathsPoints().asBroadcastStream();
    _streamSubscription = _prepareResultsToSending.listen(
            (event) {},
        onDone: () {
          _streamSubscription.cancel();
          setState(() {
            _isCanClearLocalData = true;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Short Path Result List Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services_rounded),
              onPressed: _isCanClearLocalData ? () {
                showDialog(
                  context: context,
                  builder: (context) => IsClearDataDialog(callback: (isApprove) => _clearLocalData(isApprove)),
                );
              } : null,
            ),
          ],
        ),
        body: SafeArea(
            child: Center(
              child: ResultListWidget(_prepareResultsToSending),
            )
        )
    );
  }

  void _clearLocalData(bool isApprove) {
    _isCanClearLocalData = !isApprove;

    if (isApprove) {
      LocalStorage.deleteFolder();
      setState(() {
        initStreamWithListener();
      });
    }
  }
}
