import 'dart:async';
import 'package:flutter/material.dart';

class FlutterBardLearningTimer extends StatefulWidget {
  @override
  _FlutterBardLearningTimerState createState() => _FlutterBardLearningTimerState();
}

class _FlutterBardLearningTimerState extends State<FlutterBardLearningTimer> {
  Timer? _timer;
  int _currentValue = 0;
  bool _isCountingUp = true;

  @override
  void initState() {
    super.initState();

    // Start the timer paused
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          // Update timer value
          if (_isCountingUp) {
            _currentValue++;
          } else {
            _currentValue--;
          }
        });
      },
    );
  }

  void _startTimer(int value) {
    setState(() {
      _currentValue = value;
      _isCountingUp = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          _currentValue++;
        });
      },
    );
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _resetTimer() {
    setState(() {
      _currentValue = 0;
      _isCountingUp = true;
      _timer = null;
    });
  }

  void _countDown() {
    if (_isCountingUp) {
      setState(() {
        _isCountingUp = false;
      });

      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          setState(() {
            _currentValue--;
          });
        },
      );
    } else {
      setState(() {
        _isCountingUp = true;
      });

      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          setState(() {
            _currentValue++;
          });
        },
      );
    }
  }

  void _buildButtons() {
    List<Widget> buttons = [];

    if (_timer == null) {
      buttons.add(ElevatedButton(
        onPressed: _startTimer(0),
        child: Text('Count Up'),
      ));
      buttons.add(ElevatedButton(
        onPressed: _countDown,
        child: Text('Count Down'),
      ));
      buttons.add(ElevatedButton(
        onPressed: _stopTimer,
        child: Text('Stop'),
      ));
      buttons.add(ElevatedButton(
        onPressed: _resetTimer,
        child: Text('Reset'),
      ));
    } else {
      buttons.add(ElevatedButton(
        onPressed: _stopTimer,
        child: Text('Pause'),
      ));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: buttons);
  }

  Widget _buildButton(String text, void Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
