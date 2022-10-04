import 'package:flutter/material.dart';
import 'package:short_path/presentation/widgets/preview_result_widget.dart';

class PreviewResultPage extends StatefulWidget {
  final String taskId;

  const PreviewResultPage({Key? key, required this.taskId}) : super(key: key);

  @override
  State<PreviewResultPage> createState() => _PreviewResultPageState();
}

class _PreviewResultPageState extends State<PreviewResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Short Path Preview Result Page'),
      ),
      body: SafeArea(
        child: PreviewResultWidget(
          taskId: widget.taskId,
        ),
      ),
    );
  }
}
