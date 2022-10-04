import 'package:flutter/material.dart';

import 'package:short_path/navigation/tab_item.dart';
import 'package:short_path/presentation/pages/main_page.dart';
import 'package:short_path/presentation/pages/result_list_page.dart';

class TabNavigatorRoutes {
  static const String main = '/';
  static const String resultList = '/result_list';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key? key, this.navigatorKey, required this.tabItem, required this.globalKeyBottomNavigation}) : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  final GlobalKey globalKeyBottomNavigation;

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.main,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.main: (context) => tabItem == TabItem.resultList
          ? const ResultListPage()
          : MainPage(globalKeyBottomNavigation: globalKeyBottomNavigation),
    };
  }
}
