import 'package:flutter/material.dart';

import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
import 'package:short_path/presentation/pages/preview_result_page.dart';

class ResultListCards extends StatelessWidget {
  final List<PrepareResultToSending> _prepareResultsToSending;

  const ResultListCards(this._prepareResultsToSending, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _prepareResultsToSending.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Center(
              child: Text(
                _prepareResultsToSending[index].result.steps.toResultToSending(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => PreviewResultPage(taskId: _prepareResultsToSending[index].id)
                ),
              );
            },
          ),
        );
      },
    );
  }
}