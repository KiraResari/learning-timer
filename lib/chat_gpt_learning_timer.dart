import 'package:flutter/material.dart';
import 'dart:async';

class ChatGptLearningTimer extends StatefulWidget {
  @override
  _ChatGptLearningTimerState createState() => _ChatGptLearningTimerState();
}

class _ChatGptLearningTimerState extends State<ChatGptLearningTimer> {
  Duration _currentDuration = Duration.zero;
  bool _isCountingUp = true;
  bool _isTimerRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (_isTimerRunning) {
      setState(() {
        if (_isCountingUp) {
          _currentDuration += Duration(seconds: 1);
        } else {
          _currentDuration -= Duration(seconds: 1);
          if (_currentDuration.isNegative) {
            _currentDuration = Duration.zero;
            _isTimerRunning = false;
          }
        }
      });
    }
  }

  void _startStopTimer() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _currentDuration = Duration.zero;
      _isTimerRunning = false;
    });
  }

  void _toggleCountDirection(bool countUp) {
    setState(() {
      if (_isTimerRunning) {
        if (_isCountingUp != countUp) {
          _isCountingUp = countUp;
        }
      } else {
        _isCountingUp = countUp;
        _startStopTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatDuration(_currentDuration);

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 36,
                color: _currentDuration.isNegative ? Colors.red : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _toggleCountDirection(true);
                  },
                  child: Text('Count Up'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _toggleCountDirection(false);
                  },
                  child: Text('Count Down'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isTimerRunning ? _startStopTimer : null,
                  child: Text('Stop'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _resetTimer();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.abs().toString().padLeft(2, '0');
    String formattedTime =
        '${duration.inHours}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
    return duration.isNegative ? '-$formattedTime' : formattedTime;
  }
}
