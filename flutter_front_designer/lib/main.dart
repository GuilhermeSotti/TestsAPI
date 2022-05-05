import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show Key, kIsWeb;
import 'package:flutter/material.dart'
    show AppBar, BuildContext, DefaultTabController, Icon, Icons, Key, MaterialApp,
    Scaffold, Size, StatelessWidget, Tab, TabBar, TabBarView, Text, Widget, WidgetsFlutterBinding, runApp;

import 'package:window_size/window_size.dart' show setWindowMinSize, setWindowTitle;

import 'data/transfer/data_transfer_page.dart' show DataTransferPageStarter;
import 'process/infinite/infinite_process_page.dart' show InfiniteProcessPageStarter;
import 'process/performance/performance_page.dart' show PerformancePage;

void main() {
  setupWindow();
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

const double windowWidth = 1024;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Isolate Example');
    setWindowMinSize(const Size(windowWidth, windowHeight));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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