import 'package:flutter/material.dart';

class AnimatedSplashLogo extends StatefulWidget {
  const AnimatedSplashLogo({
    super.key,
  });

  @override
  State<AnimatedSplashLogo> createState() => _AnimatedSplashLogoState();
}

class _AnimatedSplashLogoState extends State<AnimatedSplashLogo>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool hasBlur = false;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          hasBlur = false;
        });
      } else {
        setState(() {
          hasBlur = true;
        });
      }
    });

    _animation = Tween(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _animation!,
          child: Image.asset('assets/icons/favicon.jpg'),
          builder: (context, child) {
            return SizedBox(
              width: _animation!.value,
              height: _animation!.value,
              child: child,
            );
          }),
    );
  }
}
