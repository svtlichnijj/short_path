import 'package:flutter/material.dart';

import 'package:short_path/navigation/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key, required this.currentTab, required this.onSelectTab}) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Calculate',
          icon: Icon(Icons.send_time_extension_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Results',
          icon: Icon(Icons.window_rounded),
        ),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      // selectedItemColor: currentTab.path,
    );
  }
}
