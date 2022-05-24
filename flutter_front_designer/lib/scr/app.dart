import 'package:flutter/material.dart'
    show BuildContext, CupertinoPageTransitionsBuilder, FadeUpwardsPageTransitionsBuilder, GlobalKey, MaterialApp, NavigatorState, PageTransitionsTheme, State, StatefulWidget, TargetPlatform, ThemeData, Widget;
import 'package:flutter_front_designer/scr/screen/navbar_main.dart';

import 'process/services/auth.dart' show AuthenticationManager, AuthenticationManagerScope;
import 'routes.dart'
    show ParsedRoute, RouteState, RouteStateScope, SimpleRouteDelegate, TemplateRouteParser;

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  // TODO: implement createState Main
  State<StatefulWidget> createState() => _Main();
}

class _Main extends State<Main> {

  final _auth = AuthenticationManager();
  final _naviKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouteDelegate _routeDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RouteStateScope(
      notifier: _routeState,
      child: AuthenticationManagerScope(
        notifier: _auth,
        child: MaterialApp.router(
          routeInformationParser: _routeParser,
          routerDelegate: _routeDelegate,
          // Revert back to pre-Flutter-2.5 transition behavior:
          // https://github.com/flutter/flutter/issues/82053
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _routeParser = TemplateRouteParser(
        allowedPaths: [
          '/sign_in_page',
          '/settings',
          '/navbar_main',
        ],
      guard: _guard,
      initialRoute: '/sign_in_page',
    );

    _routeState = RouteState(_routeParser);

    _routeDelegate = SimpleRouteDelegate(
        routeState: _routeState,
        naviKey: _naviKey,
        builder: (context) =>
            NavBarMain(naviKey: _naviKey),
    );

    // Listen for when the user logs out and and displays the signed screen
    _auth.addListener(_handlerAuthStateChanged);

    super.initState;
  }

  Future<ParsedRoute> _guard(ParsedRoute from) async {
    final signedIn = _auth.signedIn;
    final signedInRoute = ParsedRoute('/sing_in_page', '/sign_in_page', {}, {});

    // Go to sign in page if the is not logged
    if (!signedIn && from != signedInRoute) {
      return signedInRoute;
    }
    // Go to navbar main if the user is signed in and tries to go to sign in page.
    else if (signedIn && from == signedInRoute) {
      return ParsedRoute('/navbar_main', '/navbar_main', {}, {});
    }
    return from;
  }

  void _handlerAuthStateChanged(){
    if(!_auth.signedIn) {
      _routeState.go('sign_in_page');
    }
  }

  @override
  dispose(){
    _auth.dispose();
    _routeState.dispose();
    _routeDelegate.dispose();
    super.dispose();
  }
}