import 'package:flutter/material.dart'
    show
        Alignment,
        AnimatedBuilder,
        Animation,
        AnimationController,
        BorderRadius,
        BorderRadiusTween,
        BoxDecoration,
        BuildContext,
        Center,
        Colors,
        Container,
        FlutterLogo,
        LinearGradient,
        State,
        StatefulWidget,
        TickerProviderStateMixin,
        Widget;

class SmoothAnimationWidgets extends StatefulWidget {
  const SmoothAnimationWidgets({super.key});

  @override
  // TODO: implement createState animation
  SmoothAnimationWidgetsState createState() => SmoothAnimationWidgetsState();
}

class SmoothAnimationWidgetsState extends State<SmoothAnimationWidgets> with
                                          TickerProviderStateMixin {

  late final AnimationController _animController;
  late final Animation<BorderRadius?> _borderAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0),
    ).animate(_animController);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
        animation: _borderAnimation,
        builder: (context, child) {
          return Container(
              alignment: Alignment.bottomCenter,
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
              ),
              borderRadius: _borderAnimation.value,
            ),
              child: const FlutterLogo(
                size: 200,
              ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animController.dispose();
  }
}