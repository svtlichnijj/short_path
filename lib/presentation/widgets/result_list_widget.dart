import 'package:flutter/material.dart';

import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
import 'package:short_path/presentation/widgets/result_list_cards_widget.dart';
import 'package:short_path/presentation/widgets/text_container.dart';

class ResultListWidget extends StatelessWidget {
  final Stream<List<PrepareResultToSending>> _prepareResultsToSending;

  const ResultListWidget(this._prepareResultsToSending, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _prepareResultsToSending,
        builder: (BuildContext context, AsyncSnapshot<List<PrepareResultToSending>> snapshot) {
          List<Widget> children = <Widget>[
            const CircularProgressIndicator()
          ];

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              children = TextContainer.getTextErrorList(context, 'An error has occurred: ' + snapshot.error.toString());
            }

            if (!snapshot.hasData) {
              children = TextContainer.getTextErrorList(context, 'Empty data');
            } else {
              return ResultListCards(snapshot.data!);
            }
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }
}
