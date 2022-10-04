import 'package:flutter/material.dart';

import 'package:short_path/domain/dto/results_to_sending.dart';
import 'package:short_path/navigation/tab_item.dart';
import 'package:short_path/navigation/bottom_navigation.dart';
import 'package:short_path/presentation/controllers/process_find_path.dart';
import 'package:short_path/presentation/widgets/text_container.dart';

class ProgressWidget extends StatefulWidget {
  final String? processUrl;
  final GlobalKey globalKeyBottomNavigation;

  const ProgressWidget({Key? key, this.processUrl, required this.globalKeyBottomNavigation}) : super(key: key);

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  // late Future<ProcessFindPath> futureTask;
  final ProcessFindPath _controller = ProcessFindPath();
  late Stream<ProcessFindPath> futureTask = _controller.start(widget.processUrl);
  // final PagesState _pagesState = PagesState();
  bool isActiveButton = true;

  // @override
  // void initState() {
  //   super.initState();
  //   futureTask = _controller.start(widget.processUrl);
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProcessFindPath>(
      stream: futureTask,
      // return FutureBuilder<ProcessFindPath>(
      //   future: futureTask,
      builder: (BuildContext context, AsyncSnapshot<ProcessFindPath> snapshot) {
        List<Widget> children = <Widget>[
          const CircularProgressIndicator()
        ];
        if (snapshot.hasError) {
          children = TextContainer.getTextErrorList(snapshot.error);
        } else {
          print('snapshot.connectionState');
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              children = <Widget>[
                const TextContainer(text: 'None connection ;-(')
              ];
              break;
            case ConnectionState.waiting:
              children.insert(0, const TextContainer(text: 'Waiting...'));
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                // print('--snapshot.data--');
                // print(snapshot.data);
                children = <Widget>[
                  // const Text('snapshot.hasData'),
                  TextContainer(
                      text: 'All calculations has finished, you can send your results to server',
                      isTransparent: snapshot.connectionState != ConnectionState.done,
                  ),
                  CircularProgressIndicator(
                    value: (snapshot.data!.percentageCalculation.clamp(0, 100) / 100).toDouble(),
                  ),
                  Text(snapshot.data!.percentageCalculation.toString()),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        // child: ValueListenableBuilder<bool>(
                        //     valueListenable: snapshot.data!.isCalculationFinished,
                        //     builder: (context, value, __) {
                        //       print('--value--');
                        //       print(value);
                        //       return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: snapshot.connectionState == ConnectionState.done && isActiveButton ? () =>
                        {
                          _sendFoundedPaths()
                          // setState(() => futureTask = _controller.start(null))
                        } : null,
                        // onPressed: snapshot.data?.isCalculationFinished ? () => _sendFoundedPaths() : null,
                        // onPressed: snapshot.data!.isCalculationFinished ? null : _sendFoundedPaths(/*context*/),
                        // onPressed: value ? _sendFoundedPaths : null,
                        child: const Text(
                          'Send results to server',
                          style: TextStyle(color: Colors.black),
                        ),
                        // );
                        // }
                      )
                  ),
                ];
                if (snapshot.data!.percentageCalculation == 100) {
                  // children.insert(
                  //     0,
                  //     const TextContainer(text: 'All calculations has finished, you can send your results to server'));
                  // children.add(Container(
                  //     width: double.infinity,
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: ElevatedButton(
                  //       // child: ValueListenableBuilder<bool>(
                  //       //     valueListenable: snapshot.data!.isCalculationFinished,
                  //       //     builder: (context, value, __) {
                  //       //       print('--value--');
                  //       //       print(value);
                  //       //       return ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //       ),
                  //       // onPressed: snapshot.data!.isCalculationFinished ? null : _sendFoundedPaths(/*context*/),
                  //       onPressed: snapshot.data!.isCalculationFinished ? () => _sendFoundedPaths(/*context*/) : null,
                  //       // onPressed: value ? _sendFoundedPaths : null,
                  //       child: const Text(
                  //         'Send results to server',
                  //         style: TextStyle(color: Colors.black,),
                  //         // style: Theme.of(context).textTheme.headline6,
                  //       ),
                  //       // );
                  //       // }
                  //     )
                  // ));
                } else if (snapshot.data!.percentageCalculation > 100 && snapshot.connectionState == ConnectionState.done) {
                  switchToResultPage();
                }
              } else {
                children = <Widget>[
                  const Text('Empty data'),
                ];
              }
              break;
          }
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }


  _sendFoundedPaths(/*BuildContext context*/) async { // ToDo move to _controller
    setState(() => isActiveButton = false);
    // print('processFindPath');
    // print(processFindPath);
    // await _controller.sendCalculatedPaths();
    // OR
    // List<dynamic> tasksData = await PathFinderApi().setResults(processFindPath?.prepareResultsToSending());
    // print('tasksData');
    // print(tasksData);
    List<PrepareResultToSending>? prepareResultsToSending = await _controller.sendCalculatedPaths();
    // print('prepareResultsToSending');
    // print(prepareResultsToSending);

    if (prepareResultsToSending != null) {
      /*
      Navigator.pushNamed(context, '/result_list');
       */
      // Navigator.pushNamed(context, '/result_list', arguments: Future.value(prepareResultsToSending));
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder: (context) => ResultListPage(prepareResultsToSending: Future.value(prepareResultsToSending))
      //     )
      // );
      // OR
      // _pagesState.switchPageIndex(1);
      // MaterialPageRoute(
      //   builder: (context) => ResultListPage(),
      // );
      // var globalKeys = await LocalStorage.getData(fileName: 'globalKeys');
      // print('globalKeys b');
      // print(globalKeys);
      // globalKeys = globalKeys as GlobalKey;
      // print('globalKeys a');
      // print(globalKeys);
      //
      // final BottomNavigation bottomNavigation = globalKeys.currentWidget as BottomNavigation;
      // bottomNavigation.onSelectTab(TabItem.resultList);
      switchToResultPage();
    }
    setState(() => isActiveButton = true);
  }
  void switchToResultPage() {
    final Widget? bottomNavigation = widget.globalKeyBottomNavigation.currentWidget;

    if (bottomNavigation is BottomNavigation) {
      bottomNavigation.onSelectTab(TabItem.resultList);
    }
  }
}
