import 'dart:async';

import 'package:flutter/material.dart';

class LearningTimerController extends ChangeNotifier {
  static const _countUpStep = 1;
  static const _countDownStep = -_countUpStep;
  static const _pausedStep = 0;

  Duration currentDuration = Duration.zero;
  int _timerStep = _pausedStep;
  late Timer _timer;

  LearningTimerController() {
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    currentDuration += Duration(seconds: _timerStep);
    notifyListeners();
  }

  void startCountingUp() {
    _timerStep = _countUpStep;
    notifyListeners();
  }

  void startCountingDown() {
    _timerStep = _countDownStep;
    notifyListeners();
  }

  void resetTimer() {
    currentDuration = Duration.zero;
    pauseTimer();
    notifyListeners();
  }

  void pauseTimer() {
    _timerStep = _pausedStep;
    notifyListeners();
  }

  bool get isCountDownButtonActive => _timerStep != _countDownStep;
  bool get isCountUpButtonActive => _timerStep != _countUpStep;
  bool get isPauseButtonActive => _timerStep != _pausedStep;
  bool get isResetButtonActive => currentDuration != Duration.zero;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
