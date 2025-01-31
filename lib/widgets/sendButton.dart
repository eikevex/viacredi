import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: GoogleFonts.titilliumWeb(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(
          'Enviar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
