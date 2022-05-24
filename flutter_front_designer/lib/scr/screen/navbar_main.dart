import 'package:flutter/material.dart'
    show AppBar, BuildContext, DefaultTabController, GlobalKey, Icon, Icons, MaterialApp,
    NavigatorState, Scaffold, State, StatefulWidget, Tab, TabBar, TabBarView, Text, Widget;

import 'settings.dart' show SettingsScreen;

import '../widgets.dart'
    show DataTransferPageStarter, InfiniteProcessPageStarter, PerformancePage;

class NavBarMain extends StatefulWidget {
  final GlobalKey<NavigatorState> naviKey;

  const NavBarMain({
    required this.naviKey,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NavBarMain();
}

class _NavBarMain extends State<NavBarMain> {

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        key: widget.naviKey,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.flash_on),
                  text: 'Performance',
                ),
                Tab(
                  icon: Icon(Icons.sync),
                  text: 'Infinite Process',
                ),
                Tab(
                  icon: Icon(Icons.storage),
                  text: 'Data Transfer',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Settings',
                )
              ],
            ),
            title: const Text('Isolate Example'),
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