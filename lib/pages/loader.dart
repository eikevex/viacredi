import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viacredi/widgets/animatedLogo.dart';

class LogoViacredi extends StatefulWidget {
  const LogoViacredi({super.key});

  @override
  State<LogoViacredi> createState() => _LogoViacrediState();
}

class _LogoViacrediState extends State<LogoViacredi> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          Get.offNamed('/auth');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedSplashLogo(),
        ),
      ),
    );
  }
}
