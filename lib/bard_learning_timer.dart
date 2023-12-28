import 'dart:async';
import 'package:flutter/material.dart';

class LearningTimerApp extends StatefulWidget {
  @override
  _LearningTimerAppState createState() => _LearningTimerAppState();
}

class _LearningTimerAppState extends State<LearningTimerApp> {
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  bool _isCountingUp = true;

  @override
  void initState() {
    super.initState();
    // Set the timer to null initially
    _timer = null;
  }

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    // Start the timer with the specified direction
    _timer = _timer ?? Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          if (_isCountingUp) {
            _currentDuration += const Duration(seconds: 1);
          } else {
            _currentDuration -= const Duration(seconds: 1);
          }

          // Update the timer display and font color based on the sign
          String timerDisplay = _formatTimerDuration(_currentDuration);
          if (_currentDuration.isNegative) {
            timerDisplay = '-${timerDisplay}';
            Theme.of(context).textTheme.headline4!.color = Colors.red;
          } else {
            Theme.of(context).textTheme.headline4!.color = Colors.black;
          }

          _timerDisplay = timerDisplay;
        });
      },
    );
  }

  void _resetTimer() {
    setState(() {
      _currentDuration = Duration.zero;
      _timer?.cancel();
      _timer = null;
    });
  }

  void _countDown() {
    setState(() {
      _isCountingUp = false;
    });
    _startTimer();
  }

  void _stopTimer() {
    setState(() {
      _currentDuration = _isCountingUp ? _currentDuration : Duration.zero;
      _timer?.cancel();
      _timer = null;
    });
  }

  String _formatTimerDuration(Duration duration) {
    String twoDigits(int number) {
      if (number >= 10) {
        return '$number';
      } else {
        return '0$number';
      }
    }

    String timerDisplay = '';
    if (duration.isNegative) {
      timerDisplay = '-';
    }

    timerDisplay += '<span class="math-inline">\{twoDigits\(duration\.inHours\)\}\:</span>{twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';

    return timerDisplay;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: const Text('Learning Timer'),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    _timerDisplay,
    style: Theme.of(context).textTheme.headline4,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children:
