import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:keymap/keymap.dart';

class RefinedChatGptLearningTimer extends StatefulWidget {
  const RefinedChatGptLearningTimer({super.key});

  @override
  RefinedChatGptLearningTimerState createState() =>
      RefinedChatGptLearningTimerState();
}

class RefinedChatGptLearningTimerState
    extends State<RefinedChatGptLearningTimer> {
  static const _countUpStep = 1;
  static const _countDownStep = -_countUpStep;
  static const _pausedStep = 0;

  Duration _currentDuration = Duration.zero;
  int _timerStep = _pausedStep;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    setState(() {
      _currentDuration += Duration(seconds: _timerStep);
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardWidget(
      bindings: [
        KeyAction(
          LogicalKeyboardKey.arrowUp,
          "Count Up",
          () {
            _startCountingUp();
          },
        ),
        KeyAction(
          LogicalKeyboardKey.arrowDown,
          "Count Down",
          () => _startCountingDown(),
        ),
        KeyAction(
          LogicalKeyboardKey.pause,
          "Pause Timer",
          () => _stopTimer(),
        ),
        KeyAction(
          LogicalKeyboardKey.delete,
          "Reset Timer",
          () => _resetTimer(),
        ),
      ],
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimerDisplay(context),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Text _buildTimerDisplay(BuildContext context) {
    String formattedTime = _formatDuration(_currentDuration);
    ThemeData themeData = Theme.of(context);
    return Text(
      formattedTime,
      style: TextStyle(
        fontSize: 36,
        color: _currentDuration.isNegative
            ? Colors.red
            : themeData.colorScheme.onBackground,
      ),
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCountUpButton(),
        const SizedBox(width: 20),
        _buildCountDownButton(),
        const SizedBox(width: 20),
        _buildStopButton(),
        const SizedBox(width: 20),
        _buildResetButton(),
      ],
    );
  }

  ElevatedButton _buildCountDownButton() {
    var buttonActive = _timerStep != _countDownStep;
    return ElevatedButton(
      onPressed: buttonActive ? _startCountingDown : null,
      child: const Text('Count Down [🡻]'),
    );
  }

  void _startCountingDown() {
    setState(() {
      _timerStep = _countDownStep;
    });
  }

  ElevatedButton _buildCountUpButton() {
    var buttonActive = _timerStep != _countUpStep;
    return ElevatedButton(
      onPressed: buttonActive ? _startCountingUp : null,
      child: const Text('Count Up [🡹]'),
    );
  }

  void _startCountingUp() {
    setState(() {
      _timerStep = _countUpStep;
    });
  }

  ElevatedButton _buildResetButton() {
    var buttonActive = _currentDuration != Duration.zero;
    return ElevatedButton(
      onPressed: buttonActive ? _resetTimer : null,
      child: const Text('Reset [Del]'),
    );
  }

  void _resetTimer() {
    setState(() {
      _currentDuration = Duration.zero;
      _stopTimer();
    });
  }

  ElevatedButton _buildStopButton() {
    var buttonActive = _timerStep != _pausedStep;
    return ElevatedButton(
      onPressed: buttonActive ? _stopTimer : null,
      child: const Text('Pause [Pause]'),
    );
  }

  void _stopTimer() {
    setState(() {
      _timerStep = _pausedStep;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.abs().toString().padLeft(2, '0');
    String formattedTime =
        '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
    return duration.isNegative ? '-$formattedTime' : formattedTime;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
