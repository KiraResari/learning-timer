import 'package:flutter/material.dart';
import 'dart:async';

class FlutterBardLearningTimer extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<FlutterBardLearningTimer> {
  late Timer _timer;
  int _currentValue = 0;
  bool _isCountingUp = true;

  @override
  void initState() {
    super.initState();

    // Initialize timer to 0
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Update timer value based on count direction
        if (_isCountingUp) {
          _currentValue++;
        } else {
          _currentValue--;
        }

        // Check if timer has reached 0
        if (_currentValue == 0 && !_isCountingUp) {
          // Stop timer if count down is complete
          _timer.cancel();
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
    _timer.cancel();
  }

  void _resetTimer() {
    // Set current value, count direction, and stop the timer
    setState(() {
      _currentValue = 0;
      _isCountingUp = true;
      _timer.cancel();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Learning and Relaxation Timer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_currentValue.toString().padLeft(2, '0')}:00:00",
                style: TextStyle(
                  fontSize: 48,
                  color: _currentValue >= 0 ? Colors.black : Colors.red,
                ),
              ),
              SizedBox(height: 20.0),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    List<Widget> buttons = [];

    if (_timer == null) {
      buttons.add(_buildButton('Start', _startTimer));
      buttons.add(_buildButton('Reset', _resetTimer));
      buttons.add(_buildButton('Count Down', _countDown));
    } else {
      buttons.add(_buildButton('Stop', _stopTimer));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: buttons);
  }

  Widget _buildButton(String text, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed,
      child: Text(text),
    );
  }
}
