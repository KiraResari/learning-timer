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

  void _startTimer(int value) {
    setState(() {
      _currentValue = value;
      _isCountingUp = true;
    });

    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_isCountingUp) {
          _currentValue++;
        } else {
          _currentValue--;
        }
      });
    });
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
    } else {
      buttons.add(_buildButton('Stop', _stopTimer));
    }

    buttons.add(_buildButton('Reset', _resetTimer));

    if (_isCountingUp) {
      buttons.add(_buildButton('Count Down', () {
        setState(() {
          _isCountingUp = false;
          _timer!.cancel();
          _startTimer(_currentValue);
        });
      }));
    } else {
      buttons.add(_buildButton('Count Up', () {
        setState(() {
          _isCountingUp = true;
          _timer!.cancel();
          _startTimer(_currentValue);
        });
      }));
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
