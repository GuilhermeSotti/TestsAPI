import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        BoxConstraints,
        BuildContext,
        Card,
        ConstrainedBox,
        EdgeInsets,
        Padding,
        SafeArea,
        Scaffold,
        SingleChildScrollView,
        State,
        StatefulWidget,
        Widget;

import '../process/widgets/settings_content.dart' show SettingsContent;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // TODO: implement createState SettingsScreen
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  // TODO: implement build
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    child: SettingsContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
