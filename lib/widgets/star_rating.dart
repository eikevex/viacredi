import 'package:flutter/material.dart';
import 'package:viacredi/utils/timer.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;
  final TimerProvider timerProvider;

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    required this.timerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            int newRating = index + 1;
            if (newRating == 0 && rating == 0) {
              newRating = 1;
            }
            onRatingChanged(newRating);

            // Resetar o timer quando uma estrela é clicada
            timerProvider.resetTimer(seconds: 30);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.asset(
              index < rating
                  ? 'assets/images/estrela_active.png'
                  : 'assets/images/starlight.png',
              width: 60,
              height: 60,
            ),
          ),
        );
      }),
    );
  }
}
