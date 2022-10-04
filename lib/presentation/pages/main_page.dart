import 'package:flutter/material.dart';
import 'package:short_path/presentation/icons/flutter_icons_icons.dart';
import 'package:short_path/presentation/pages/process_page.dart';
import 'package:short_path/services/validate_url_service.dart';

class MainPage extends StatefulWidget {
  final GlobalKey globalKeyBottomNavigation;

  const MainPage({Key? key, required this.globalKeyBottomNavigation/*, required this.onSubmit*/}) : super(key: key);
  // final ValueChanged<String> onSubmit;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValidateUrlService _controller = ValidateUrlService();

  // late ValidateUrlService _controller;
  // bool _submitted = false;
  String? _errorText;

  // initState it when the widget is init
  @override
  void initState() {
    // _controller = ValidateUrlService();
    super.initState();

    _controller.urlTextEditing.addListener(_controller.isEmptyField);
  }

  // create it when running the widget
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
                child: /*ValueListenableBuilder(
                        valueListenable: _controller.urlTextEditing,
                        builder: (context, value, __) {
                          return */ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(FlutterIcons.exchange),
                        title: TextField(
                          controller: _controller.urlTextEditing,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(bottom: 12.0),
                              labelText: 'Enter valid URL',
                              errorText: _errorText
                            // errorText: _submitted
                            //     ? _controller.getErrorText()
                            //     : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ) /*;
                        })*/
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
                        child: const Text(
                          'Start',
                          // style: Theme.of(context).textTheme.headline6,
                        ),
                      );
                    }
                )
            )
          ],
        ),
      ),
      /*
        bottomNavigationBar: NavigationBar(
          // selectedIndex: currentPageIndex,
            destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.send_time_extension_rounded),
            label: 'Calculate',
          ),
          NavigationDestination(
            icon: Icon(Icons.window_rounded),
            label: 'Results',
          ),
        ],
        ),
         */
      /*
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                // // pushReplacementNamed will execute the enter animation
                // Navigator.of(context).pushReplacementNamed('/screen4');
                // //popAndPushNamed will execute the exit animation.
                // Navigator.pushReplacementNamed(context, '/screen4');
                Navigator.popAndPushNamed(context,  '/result_list');
              }
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
       */
    );
  }

  _startProcess() {
    // print('_submit');
    setState(() => _errorText = _controller.getErrorText());
    // setState(() => _submitted = true);
    // String? errorText = _controller.getErrorText();

    if (_errorText == null) {
      // if (errorText != null) {
      // notify the parent widget via the onSubmit callback
      // print('_submit errorText is not NULL: ' + _errorText.toString());
      // print('_submit errorText is not NULL: ' + errorText.toString());
      // print('entered _submit Text: ' + _controller.urlTextEditing.text);
      // widget.onSubmit(_controller.urlTextEditing.text);
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ProcessPage(
                    processUrl: _controller.urlTextEditing.text,
                    globalKeyBottomNavigation: widget.globalKeyBottomNavigation,
                  )
          )
      );
    }
  }
}
