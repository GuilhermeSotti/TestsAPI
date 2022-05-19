import 'package:flutter/material.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  // TODO: implement build SettingsContent
  Widget build(BuildContext context) {
    return Column(children: [
      ...[
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headline4,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sing in'),
        ),
      ]
    ]);
  }
}
