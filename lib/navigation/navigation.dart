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
  TabItem _currentTab = TabItem.main;
  final _navigatorKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.resultList: GlobalKey<NavigatorState>(),
  };
  GlobalKey globalKeyBottomNavigation = GlobalKey(debugLabel: 'btm_nav');

  @override
  void initState() {
    LocalStorage.deleteFolder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.main) { // if not on the 'main' tab
            _selectTab(TabItem.main); // select 'main' tab
            return false; // back button handled by app
          }
        }

        return isFirstRouteInCurrentTab; // let system handle back button if we're on the first route
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
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst); // pop to first route
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
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
