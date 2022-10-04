import 'package:flutter/material.dart';
import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/navigation/bottom_navigation.dart';
import 'package:short_path/navigation/tab_item.dart';
import 'package:short_path/navigation/tab_navigator.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // TabItem _currentTab = TabItem.resultList;
  TabItem _currentTab = TabItem.main;
  // var _currentTab = TabItem.main;
  final _navigatorKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.resultList: GlobalKey<NavigatorState>(),
  };
  GlobalKey globalKeyBottomNavigation = GlobalKey(debugLabel: 'btm_nav');

  @override
  void initState() {
    super.initState();
    // print('globalKeyBottomNavigation');
    // print(globalKeyBottomNavigation);
    // print('globalKeyBottomNavigation.toString()');
    // print(globalKeyBottomNavigation.toString());
    // LocalStorage.setData(globalKeyBottomNavigation.toString(), fileName: 'globalKeys');
    LocalStorage.deleteFolder();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.main) {
            // select 'main' tab
            _selectTab(TabItem.main);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.main),
          _buildOffstageNavigator(TabItem.resultList),
        ]),
        bottomNavigationBar: BottomNavigation(
          key: globalKeyBottomNavigation,
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  void _selectTab(TabItem tabItem) {
    // print('--333_selectTab--');
    // print('tabItem');
    // print(tabItem);
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      // print('_currentTab b');
      // print(_currentTab);
      setState(() => _currentTab = tabItem);
      // print('_currentTab a');
      // print(_currentTab);
      // print('_navigatorKeys');
      // print(_navigatorKeys);
      // print('_navigatorKeys[tabItem]');
      // print(_navigatorKeys[tabItem]);
      // _navigatorKeys[_currentTab];
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder: (context) => const ResultListPage()
      //     )
      // );
          // return MaterialPageRoute(
          //     builder: (context) {
          //       return ResultListPage();
          //     }
          // );
      // switch(_currentTab) {
      //   case TabItem.main:
      //     Navigator.pushNamed(context, "/first");
      //     break;
      //   case TabItem.resultList:
      //     Navigator.pushNamed(context, "/second");
      //     break;
      // }
    }
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    // print('--111_buildOffstageNavigator--');
    // print('tabItem');
    // print(tabItem);
    // print('_currentTab');
    // print(_currentTab);
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        globalKeyBottomNavigation: globalKeyBottomNavigation,
      ),
    );
  }
}
