import 'package:flutter/material.dart'
    show AppBar, BuildContext, DefaultTabController, Icon, Icons,
    Key, MaterialApp, Scaffold, State, StatefulWidget, Tab, TabBar,
    TabBarView, Text, Widget;

import 'widgets.dart'
    show DataTransferPageStarter, InfiniteProcessPageStarter, PerformancePage;

class NavBarMain extends StatefulWidget {
  const NavBarMain({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavBarMain();
}

class _NavBarMain extends State<NavBarMain> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
              ],
            ),
            title: const Text('Isolate Example'),
          ),
          body: const TabBarView(
            children: [
              PerformancePage(),
              InfiniteProcessPageStarter(),
              DataTransferPageStarter(),
            ],
          ),
        ),
      ),
    );
  }
}