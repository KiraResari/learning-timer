import 'dart:async';
import 'package:flutter/material.dart';

class BardLearningTimer extends StatefulWidget {
  @override
  _BardLearningTimerState createState() => _BardLearningTimerState();
}

class _BardLearningTimerState extends State<BardLearningTimer> {
  late Timer _timer;
  Duration _currentDuration = Duration.zero;
  String _timerDisplay = '00:00:00';
  bool _isCountingUp = true;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          if (_isCountingUp && _currentDuration.isNegative) {
            _currentDuration = Duration.zero;
            _timer.cancel();
          } else if (!_isCountingUp && _currentDuration.inMilliseconds == 0) {
            _timer.cancel();
          } else {
            _currentDuration = _isCountingUp ? _currentDuration + const Duration(seconds: 1) : _currentDuration - const Duration(seconds: 1);
            _timerDisplay = _formatTimerDuration(_currentDuration);
          }
        });
      },
    );
  }

  void _resetTimer() {
    setState(() {
      _currentDuration = Duration.zero;
      _timerDisplay = '00:00:00';
      _isCountingUp = true;
      _timer.cancel();
    });
  }

  void _countDown() {
    setState(() {
      _isCountingUp = false;
    });
    _startTimer();
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    setState(() {
      _currentDuration = _isCountingUp ? _currentDuration : Duration.zero;
      _timerDisplay = _formatTimerDuration(_currentDuration);
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

    return '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
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
                children: [
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: Text(_isCountingUp ? 'Start Counting Up' : 'Start Counting Down'),
                  ),
                  ElevatedButton(
                    onPressed: _countDown,
                    child: Text('Count Down'),
                  ),
                  ElevatedButton(
                    onPressed: _stopTimer,
                    child: Text('Stop'),
                  ),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
