import 'package:flutter/material.dart'
    show
        BottomNavigationBar,
        BottomNavigationBarItem,
        BuildContext,
        DefaultTabController,
        Icon,
        Icons,
        SafeArea,
        Scaffold,
        StatelessWidget,
        TabBarView,
        Widget;
import 'package:flutter_front_designer/scr/widgets.dart'
    show
        DataTransferPageStarter,
        InfiniteProcessPageStarter,
        PerformancePage,
        SettingsScreen;

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) => _NavigationBar();
}

class _NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.flash_on),
                label: 'Performance',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sync),
                label: 'Infinite Process',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storage),
                label: 'Data Transfer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              PerformancePage(),
              InfiniteProcessPageStarter(),
              DataTransferPageStarter(),
              SettingsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
