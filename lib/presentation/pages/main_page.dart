import 'package:flutter/material.dart';

import 'package:short_path/presentation/icons/flutter_icons_icons.dart';
import 'package:short_path/presentation/pages/process_page.dart';
import 'package:short_path/services/validate_url_service.dart';

class MainPage extends StatefulWidget {
  final GlobalKey globalKeyBottomNavigation;

  const MainPage({Key? key, required this.globalKeyBottomNavigation}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValidateUrlService _controller = ValidateUrlService();

  String? _errorText;

  @override
  void initState() {
    super.initState();

    _controller.urlTextEditing.addListener(_controller.isEmptyField);
  }

  @override
  void dispose() {
    _controller.urlTextEditing.dispose();
    _controller.isStartCountingProcess.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Short Path Home Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Set valid API base URL in order to continue'),
              )
            ]),
            Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(FlutterIcons.exchange),
                        title: TextField(
                          controller: _controller.urlTextEditing,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 12.0),
                            labelText: 'Enter valid URL',
                            errorText: _errorText,
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: ValueListenableBuilder<bool>(
                    valueListenable: _controller.isStartCountingProcess,
                    builder: (context, value, __) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: value ? _startProcess : null,
                        child: const Text('Start'),
                      );
                    })
            )
          ],
        ),
      ),
    );
  }

  _startProcess() {
    setState(() => _errorText = _controller.getErrorText());

    if (_errorText == null) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ProcessPage(
                      processUrl: _controller.urlTextEditing.text,
                      globalKeyBottomNavigation: widget.globalKeyBottomNavigation
                  )
          )
      );
    }
  }
}
