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
    // print('--222TabNavigator--');
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.main,
      onGenerateRoute: (routeSettings) {
        // print('routeSettings');
        // print(routeSettings);
        // print('routeSettings.name');
        // print(routeSettings.name);
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    // print('--22_routeBuilders--');
    // print('navigatorKey');
    // print(navigatorKey);
    // print('tabItem');
    // print(tabItem);
    return {
      TabNavigatorRoutes.main: (context) => tabItem == TabItem.resultList
          ? ResultListPage()
          : MainPage(globalKeyBottomNavigation: globalKeyBottomNavigation,),
    };
    /*
    return {
      TabNavigatorRoutes.main: (context) => MainPage(
        // onPush: (materialIndex) => _push(context),
      ),
      TabNavigatorRoutes.resultList: (context) => ResultListPage(
        // materialIndex: materialIndex,
      ),
    };
     */
  }

  /*
  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.resultList]!(context),
            // routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }
   */
}
