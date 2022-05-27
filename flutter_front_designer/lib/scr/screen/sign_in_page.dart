import 'package:flutter/material.dart'
    show
        BoxConstraints,
        BuildContext,
        Card,
        Center,
        Column,
        Container,
        EdgeInsets,
        InputDecoration,
        MainAxisAlignment,
        MainAxisSize,
        Padding,
        Scaffold,
        Size,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextField,
        Theme,
        ValueChanged,
        Widget;

import '../data/constants.dart' show Credentials;

class SignInPage extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInPage({
    required this.onSignIn,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  // TODO: implement build SignInPage
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            constraints: BoxConstraints.loose(const Size(600, 600)),
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sign in', style: Theme.of(context).textTheme.headline4),
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () async {
                      widget.onSignIn(Credentials(
                        _usernameController.value.text,
                        _passwordController.value.text,
                      ));
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
