import 'package:flutter/material.dart';
import 'package:short_path/domain/dto/results_to_sending.dart';
import 'package:short_path/presentation/pages/preview_result_page.dart';
import 'package:short_path/presentation/widgets/text_container.dart';

class ResultListWidget extends StatefulWidget {
  // final Future<List<PrepareResultToSending>> prepareResultsToSending;

  const ResultListWidget({Key? key/*, required this.prepareResultsToSending*/}) : super(key: key);

  @override
  State<ResultListWidget> createState() => _ResultListWidgetState();
}

class _ResultListWidgetState extends State<ResultListWidget> {
  // final ProcessFindPath _controller = ProcessFindPath();
  // late Stream<ProcessFindPath> futureTask = _controller.start(widget.processUrl);
  final Stream<List<PrepareResultToSending>> _prepareResultsToSending = PrepareResultToSending.listFromLocalPathsPoints();
  // late List<PrepareResultToSending> _prepareResultsToSending = [];

  @override
  void initState() {
    super.initState();
    // print('widget.prepareResultsToSending');
    // print(widget.prepareResultsToSending);
    // print('_prepareResultsToSending b');
    // print(_prepareResultsToSending);
    // print('_prepareResultsToSending.runtimeType b');
    // print(_prepareResultsToSending.runtimeType);
    // // _prepareResultsToSending = await widget.prepareResultsToSending;
    // // setState(() async => _prepareResultsToSending = await widget.prepareResultsToSending);
    // print('_prepareResultsToSending a');
    // print(_prepareResultsToSending);
    // print('_prepareResultsToSending.runtimeType a');
    // print(_prepareResultsToSending.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    // return FutureBuilder(
        stream: _prepareResultsToSending,
        // future: _prepareResultsToSending,
        // future: widget.prepareResultsToSending,
        builder: (BuildContext context, AsyncSnapshot<List<PrepareResultToSending>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('snapshot.hasError');
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              print('snapshot.hasData');
              print(snapshot.data);
              if (snapshot.data != null) {
                return ResultListCards(prepareResultsToSending: snapshot.data!);
              } else {
                return const TextContainer(text: 'Empty data');
              }
            } else {
              print('snapshot.else');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            print('connectionState != done');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}

class ResultListCards extends StatelessWidget {
  final List<PrepareResultToSending> prepareResultsToSending;

  const ResultListCards({Key? key, required this.prepareResultsToSending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('prepareResultsToSending build');
    // print(prepareResultsToSending);
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
              builder: (context) => PreviewResultPage(
                taskId: prepareResultsToSending[index].id,
              ),
            ),
          );
        },
      ),
    );
  }
}

