import 'package:flutter/material.dart';

class FadeTransitionPager<T> extends Page<T> {
  final Widget child;
  final Duration duration;

  const FadeTransitionPager(
      {required super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 300)});

  @override
  // TODO: implement createRoute
  Route<T> createRoute(BuildContext context) =>
      PageBaseFadeTransitionRoute<T>(this);
}

class PageBaseFadeTransitionRoute<T> extends PageRoute<T> {
  final FadeTransitionPager<T> _page;

  PageBaseFadeTransitionRoute(this._page) : super(settings: _page);

  @override
  Color? get barrierColor => throw UnimplementedError();

  @override
  String? get barrierLabel => throw UnimplementedError();

  @override
  bool get maintainState => throw UnimplementedError();

  @override
  Duration get transitionDuration => _page.duration;

  @override
  // TODO: implement buildPage
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    var curveBeTween = CurveTween(curve: Curves.easeIn);
    return FadeTransition(
      opacity: animation.drive(curveBeTween),
      child: (settings as FadeTransitionPager).child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      child;
}
