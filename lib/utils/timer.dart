import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _secondsRemaining = 30;

  int get secondsRemaining => _secondsRemaining;

  void startTimer({int? seconds}) {
    _secondsRemaining = seconds ?? 30;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer({int? seconds}) {
    _secondsRemaining = seconds ?? 30;
    startTimer(seconds: _secondsRemaining);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
