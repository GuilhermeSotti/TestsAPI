import 'package:flutter/material.dart'
    show Alignment, AnimatedBuilder, Animation, AnimationController, BorderRadius,
    BorderRadiusTween, BoxDecoration, BuildContext, Center, Colors, Container, FlutterLogo,
    Key, LinearGradient, State, StatefulWidget, TickerProviderStateMixin, Widget;

class SmoothAnimationWidgets extends StatefulWidget {
  const SmoothAnimationWidgets({Key? key}) : super(key: key);

  @override
  SmoothAnimationWidgetsState createState() =>
    // TODO: implement createState animation
    SmoothAnimationWidgetsState();


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
              child: const FlutterLogo(
                size: 200,
              ),
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