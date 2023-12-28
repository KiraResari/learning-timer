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
  Duration _currentDuration = Duration.zero;
  int _timerStep = 0;
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

  ElevatedButton _buildResetButton() {
    return ElevatedButton(
      onPressed: () => _resetTimer(),
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
    return ElevatedButton(
      onPressed: _isTimerRunning() ? _stopTimer : null,
      child: const Text('Stop'),
    );
  }

  bool _isTimerRunning(){
    return _timerStep != 0;
  }

  void _stopTimer() {
    setState(() {
      _timerStep = 0;
    });
  }

  ElevatedButton _buildCountDownButton() {
    return ElevatedButton(
      onPressed: _startCountingDown,
      child: const Text('Count Down'),
    );
  }

  void _startCountingDown(){
    setState(() {
      _timerStep = -1;
    });
  }

  ElevatedButton _buildCountUpButton() {
    return ElevatedButton(
      onPressed: _startCountingUp,
      child: const Text('Count Up'),
    );
  }

  void _startCountingUp(){
    setState(() {
      _timerStep = 1;
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
