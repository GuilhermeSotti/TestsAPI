import 'dart:async' show Future;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        ChangeNotifier,
        GlobalKey,
        NavigatorState,
        PopNavigatorRouterDelegateMixin,
        RouterDelegate,
        Widget,
        WidgetBuilder;

import 'parsed_routed.dart' show ParsedRoute;
import 'route_state.dart' show RouteState;

class SimpleRouteDelete extends RouterDelegate<ParsedRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ParsedRoute> {
  final RouteState routeState;
  final WidgetBuilder builder;

  final GlobalKey<NavigatorState> naviKey;

  SimpleRouteDelete({
    required this.routeState,
    required this.builder,
    required this.naviKey,
  }) {
    routeState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) => builder(context);

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => throw UnimplementedError();

  @override
  // TODO: implement setNewRoutePath
  Future<void> setNewRoutePath(ParsedRoute configuration) async =>
      SynchronousFuture(null);

  @override
  ParsedRoute get currentConfiguration => routeState.route;

  @override
  void dispose() {
    routeState.removeListener(notifyListeners);
    routeState.dispose();
    super.dispose();
  }
}
