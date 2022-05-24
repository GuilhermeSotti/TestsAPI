import 'package:flutter/material.dart'
    show AlertDialog, BuildContext, Column, EdgeInsets, ElevatedButton, Navigator, Padding, StatelessWidget, Text, TextButton, Theme, Widget, showDialog;

import '../services/auth.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  // TODO: implement build SettingsContent
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
            onPressed: () {
              AuthenticationManagerScope.of(context).signOut();
            },
            child: const Text('Sing out'),
          ),
       ].map((widget) => Padding(padding: const EdgeInsets.all(8), child: widget)),
        TextButton(
          onPressed: () =>
              showDialog<String>(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text('The alert description goes here.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              ),
          child: const Text('Show Dialog'),
        ),
      ],
    );
  }
}
