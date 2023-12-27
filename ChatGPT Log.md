# Kira

Please write me a flutter app that fulfills the following user story and requirements:

As someone who learns things in his free time, I want a program that can help me balance learning time with relaxation time.

Requirements:

* A timer that can count up and down
* The timer should display time in the format `hh:mm:ss`
* If the time is negative, the time should be displayed in the format `-hh:mm:ss`, and the font should be red
* A button to make the timer count up
* A button to make the timer count down
* A button to stop the timer at its current value
* A button to reset the timer to 00:00:00

# ChatGPT

Certainly! Below is a simple Flutter app that fulfills the user story and meets the specified requirements:

```
dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LearningTimer(),
    );
  }
}

class LearningTimer extends StatefulWidget {
  @override
  _LearningTimerState createState() => _LearningTimerState();
}

class _LearningTimerState extends State<LearningTimer> {
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
```

This Flutter app includes a timer that can count up or down, buttons to control the timer, and formatting to display the time in the specified format. It should help you balance learning time with relaxation time. Feel free to customize it further based on your preferences!