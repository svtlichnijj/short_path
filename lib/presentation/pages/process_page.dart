import 'package:flutter/material.dart';

import 'package:short_path/presentation/widgets/progress_widget.dart';

class ProcessPage extends StatefulWidget {
  final String? processUrl;
  final GlobalKey globalKeyBottomNavigation;

  const ProcessPage({Key? key, this.processUrl, required this.globalKeyBottomNavigation}) : super(key: key);

  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Short Path Process Page'),
        ),
        body: SafeArea(
            child: Center(
                child: ProgressWidget(
                  processUrl: widget.processUrl,
                  globalKeyBottomNavigation: widget.globalKeyBottomNavigation,
                )
            )
        )
    );
  }
}
