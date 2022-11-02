import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
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
  final ProcessFindPath _controller = ProcessFindPath();
  late Stream<ProcessFindPath> futureTask = _controller.start(widget.processUrl);
  bool isActiveButton = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProcessFindPath>(
      stream: futureTask,
      builder: (BuildContext context, AsyncSnapshot<ProcessFindPath> snapshot) {
        if (kDebugMode) {
          print('snapshot.connectionState');
          print(snapshot.connectionState);
        }

        List<Widget> children = <Widget>[
          const CircularProgressIndicator()
        ];

        if (snapshot.hasError) {
          children = TextContainer.getTextErrorList(context, snapshot.error.toString());
        } else {
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
                int percentageCalculation = snapshot.data!.percentageCalculation;
                bool isDone = snapshot.connectionState == ConnectionState.done;
                children = <Widget>[
                  TextContainer(
                    text: 'All calculations has finished, you can send your results to server',
                    isTransparent: !isDone,
                  ),
                  CircularProgressIndicator(
                    value: isActiveButton ? (percentageCalculation.clamp(0, 100) / 100).toDouble() : null,
                  ),
                  TextContainer(
                    text: percentageCalculation.toString(),
                    isTransparent: !isActiveButton,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: isDone && isActiveButton ? () => _sendFoundedPaths() : null,
                        child: const Text(
                          'Send results to server',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                  ),
                ];
              } else {
                children = TextContainer.getTextErrorList(context, 'Empty data');
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


  void _sendFoundedPaths() async {
    setState(() => isActiveButton = false);
    List<PrepareResultToSending>? prepareResultsToSending = await _controller.sendCalculatedPaths();

    if (prepareResultsToSending != null) {
      _switchToResultPage();
    }

    setState(() => isActiveButton = true);
  }

  void _switchToResultPage() {
    final Widget? bottomNavigation = widget.globalKeyBottomNavigation.currentWidget;

    if (bottomNavigation is BottomNavigation) {
      bottomNavigation.onSelectTab(TabItem.resultList);
    }
  }
}
