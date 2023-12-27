import 'dart:async';

import 'package:flutter/material.dart';

class ChatGptLearningTimer extends StatefulWidget {
  const ChatGptLearningTimer({super.key});

  @override
  ChatGptLearningTimerState createState() => ChatGptLearningTimerState();
}

class ChatGptLearningTimerState extends State<ChatGptLearningTimer> {
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
    setState(() {
      if (_isCountingUp) {
        _currentDuration += Duration(seconds: 1);
      } else {
        _currentDuration -= Duration(seconds: 1);
      }
    });
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
      _isCountingUp = true;
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
                    setState(() {
                      _isCountingUp = true;
                      _startStopTimer();
                    });
                  },
                  child: Text('Count Up'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isCountingUp = false;
                      _startStopTimer();
                    });
                  },
                  child: Text('Count Down'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _startStopTimer();
                    });
                  },
                  child: Text(_isTimerRunning ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _resetTimer();
                    });
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
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String formattedTime =
        '${duration.inHours}:${twoDigitMinutes}:${twoDigitSeconds}';
    return duration.isNegative ? '-$formattedTime' : formattedTime;
  }
}
