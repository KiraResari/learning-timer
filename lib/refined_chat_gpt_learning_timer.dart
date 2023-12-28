import 'package:flutter/material.dart';
import 'dart:async';

class RefinedChatGptLearningTimer extends StatefulWidget {
  const RefinedChatGptLearningTimer({super.key});

  @override
  RefinedChatGptLearningTimerState createState() =>
      RefinedChatGptLearningTimerState();
}

class RefinedChatGptLearningTimerState
    extends State<RefinedChatGptLearningTimer> {
  static final _countUpStep = 1;
  static final _countDownStep = -_countUpStep;
  static final _pausedStep = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimerDisplay(),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Text _buildTimerDisplay() {
    String formattedTime = _formatDuration(_currentDuration);
    return Text(
      formattedTime,
      style: TextStyle(
        fontSize: 36,
        color: _currentDuration.isNegative ? Colors.red : Colors.black,
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
      child: const Text('Count Down'),
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
      child: const Text('Count Up'),
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
      child: const Text('Reset'),
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
      child: const Text('Stop'),
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
