import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class LearningTimerController extends ChangeNotifier {
  static const _countUpStep = 1;
  static const _countDownStep = -_countUpStep;
  static const _pausedStep = 0;

  Duration currentDuration = Duration.zero;
  int _timerStep = _pausedStep;
  late Timer _timer;

  LearningTimerController() {
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    _registerHotkeys();
  }

  void _updateTimer(Timer timer) {
    currentDuration += Duration(seconds: _timerStep);
    notifyListeners();
  }

  void _registerHotkeys() {
    hotKeyManager.register(
      HotKey(
        key: PhysicalKeyboardKey.arrowUp,
        modifiers: [HotKeyModifier.control],
      ),
      keyDownHandler: (_) => startCountingUp(),
    );
    hotKeyManager.register(
      HotKey(
        key: PhysicalKeyboardKey.arrowDown,
        modifiers: [HotKeyModifier.control],
      ),
      keyDownHandler: (_) => startCountingDown(),
    );
    hotKeyManager.register(
      HotKey(
        key: PhysicalKeyboardKey.keyP,
        modifiers: [HotKeyModifier.control],
      ),
      keyDownHandler: (_) => pauseTimer(),
    );
    hotKeyManager.register(
      HotKey(
        key: PhysicalKeyboardKey.delete,
        modifiers: [HotKeyModifier.control],
      ),
      keyDownHandler: (_) => resetTimer(),
    );
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
