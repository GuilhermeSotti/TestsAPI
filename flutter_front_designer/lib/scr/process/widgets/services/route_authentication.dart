import 'package:flutter/material.dart'
    show
        BuildContext,
        GlobalKey,
        Navigator,
        NavigatorState,
        State,
        StatefulWidget,
        ValueKey,
        Widget;
import 'package:flutter_front_designer/scr/routes.dart' show RouteStateScope;
import 'package:flutter_front_designer/scr/screen/sign_in_page.dart'
    show SignInPage;

import '../navigation_bar.dart' show NavigationBar;
import 'auth.dart' show AuthenticationManagerScope;
import 'fade_transition_page.dart' show FadeTransitionPager;

class RouteAuthentication extends StatefulWidget {
  final GlobalKey<NavigatorState> naviKey;

  const RouteAuthentication({
    required this.naviKey,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RouteAuthentication();
}

class _RouteAuthentication extends State<RouteAuthentication> {
  final _signedInKey = const ValueKey("Sign In");
  final _scaffoldKey = const ValueKey("App scaffold");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final routeState = RouteStateScope.of(context);
    final authState = AuthenticationManagerScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    // This widget is the root of the application.
    return Navigator(
      key: widget.naviKey,
      pages: [
        if (pathTemplate == '/sign_in_page')
          // display sign page
          FadeTransitionPager<void>(
            key: _signedInKey,
            child: SignInPage(onSignIn: (credentials) async {
              var signedIn = await authState.signIn(
                  credentials.username, credentials.password);
              if (signedIn) {
                await routeState.go('/navigation_bar');
              }
            }),
          )
        else ...[
          // display application
          FadeTransitionPager<void>(
            key: _scaffoldKey,
            child: const NavigationBar(),
          ),
        ],
      ],
    );
  }
}
