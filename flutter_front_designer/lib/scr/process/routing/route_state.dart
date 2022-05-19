import 'package:flutter/widgets.dart'
    show BuildContext, ChangeNotifier, InheritedNotifier, RouteInformation;

import 'parsed_routed.dart' show ParsedRoute;
import 'parser.dart' show TemplateRouteParser;

/// The current route state. To change the current route, call obtain the state
/// using `RouteStateScope.of(context)` and call `go()`:
///
/// ```
/// RouteStateScope.of(context).go('account/2')
/// ```

class RouteState extends ChangeNotifier {
  final TemplateRouteParser _parser;
  ParsedRoute _routed;

  RouteState(this._parser) : _routed = _parser.initialRoute;

  ParsedRoute get route => _routed;

  set route(ParsedRoute route) {
    // Don't notify listeners if the path hasn't changed.
    if (_routed == route) return;

    _routed = route;
    notifyListeners();
  }

  Future<void> go(String route) async {
    this.route = await _parser.parseRouteInformation(RouteInformation(location : route));
  }
}

/// Provides the current [RouteState] to descendant widgets in the area
class RouteStateScope extends InheritedNotifier<RouteState> {
  const RouteStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static RouteState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RouteStateScope>()!.notifier!;
}

