import 'package:flutter/material.dart';

import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
import 'package:short_path/presentation/pages/preview_result_page.dart';
import 'package:short_path/presentation/widgets/text_container.dart';

class ResultListWidget extends StatefulWidget {

  const ResultListWidget({Key? key/*, required this.prepareResultsToSending*/}) : super(key: key);

  @override
  State<ResultListWidget> createState() => _ResultListWidgetState();
}

class _ResultListWidgetState extends State<ResultListWidget> {
  final Stream<List<PrepareResultToSending>> _prepareResultsToSending = PrepareResultToSending.listFromLocalPathsPoints();

  @override
  void initState() {
    super.initState();
  }

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
              children = TextContainer.getTextErrorList(context, 'An error has occurred!');
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ResultListCards(prepareResultsToSending: snapshot.data!);
              } else {
                children = TextContainer.getTextErrorList(context, 'Empty data');
              }
            }
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        }
    );
  }
}

class ResultListCards extends StatelessWidget {
  final List<PrepareResultToSending> prepareResultsToSending;

  const ResultListCards({Key? key, required this.prepareResultsToSending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: prepareResultsToSending.length,
      itemBuilder: _resultListBuilder,
    );
  }

  Widget _resultListBuilder(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Center(
          child: Text(
            prepareResultsToSending[index].result.steps.toResultToSending(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) {
                  return PreviewResultPage(
                    taskId: prepareResultsToSending[index].id,
                  );
                }
            ),
          );
        },
      ),
    );
  }
}

