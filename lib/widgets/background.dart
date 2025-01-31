import 'package:flutter/material.dart';
import 'package:viacredi/widgets/header.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: -3,
            child: Image.asset(
              'assets/images/desenho.png',
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              CustomHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}