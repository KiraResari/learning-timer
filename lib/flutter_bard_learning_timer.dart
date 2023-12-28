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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Update timer value
        if (_isCountingUp) {
          _currentValue++;
        } else {
          _currentValue--;
        }
      });
    });
  }

  void _startTimer(int value) {
    setState(() {
      // Set current value and count direction
      _currentValue = value;
      _isCountingUp = true;
    });

    // Start the timer
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

  void _stopTimer() {
    // Stop the timer
    _timer!.cancel();
  }

  void _resetTimer() {
    // Set current value, count direction, and stop the timer
    setState(() {
      _currentValue = 0;
      _isCountingUp = true;
      _timer?.cancel();
    });
  }

  void _countDown() {
    if (_isCountingUp) {
      setState(() {
        // Reverse count direction
        _isCountingUp = false;
      });

      // Start the countdown timer
      _startTimer(_currentValue);
    } else {
      setState(() {
        // Revert to count up
        _isCountingUp = true;
      });

      // Start the count up timer
      _startTimer(_currentValue);
    }
  }

  void _buildButtons() {
    List<Widget> buttons = [];

    if (_timer == null) {
      buttons.add(
        _buildButton('Start', () => _startTimer(0),
        ),
      );
      buttons.add(
        _buildButton('Count Up', () => _startTimer(_currentValue),
        ),
      );
      buttons.add(
        _buildButton('Count Down', () => _countDown,
        ),
      );
      buttons.add(
        _buildButton('Reset', () => _resetTimer,
        ),
      );
    } else {
      buttons.add(_buildButton('Stop', () => _stopTimer),
      );
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: buttons);
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
