import 'package:flutter/material.dart' show BuildContext, ChangeNotifier, InheritedNotifier;

// mock authentication services
class AuthenticationManager extends ChangeNotifier {

  bool _signedIn = false;
  bool get signedIn => _signedIn;

  Future<bool> singIn() async {
    delay();

    // Sign in allowed in any password
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  Future<void> signOut() async {
    delay();

    // Sign out
    _signedIn = true;
    notifyListeners();
  }

  Future<void> delay() async =>
      await Future<void>.delayed(const Duration(milliseconds: 200));

  @override
  bool operator == (Object other) =>
      other is AuthenticationManager && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class AuthenticationManagerScope extends InheritedNotifier<AuthenticationManager> {

  const AuthenticationManagerScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static AuthenticationManager of (BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<AuthenticationManagerScope>()!
          .notifier!;
}