import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final int number;
  final TextEditingController controller;

  const NumberButton({
    super.key,
    required this.number,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          controller.text += '$number';
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class BackspaceButton extends StatelessWidget {
  final TextEditingController controller;

  const BackspaceButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          if (controller.text.isNotEmpty) {
            controller.text = controller.text.substring(0, controller.text.length - 1);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Icon(
          Icons.backspace_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}