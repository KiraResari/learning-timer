import 'dart:async';
import 'package:flutter/material.dart';

class FlutterBardLearningTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Learning and Relaxation Timer'),
        ),
        body: Center(
          child: TimerAppState(),
        ),
      ),
    );
  }
}

class TimerAppState extends State<TimerAppState> {
  Timer? _timer;
  int _currentValue = 0;
  bool _isCountingUp = true;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }

  void _startTimer(int value) {
    setState(() {
      _currentValue = value;
      _isCountingUp = true;
    });

    _timer!.cancel();
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
      _isCountingUp = false;
      _timer!.cancel();
      _startTimer(_currentValue);
    } else {
      _isCountingUp = true;
      _timer!.cancel();
      _startTimer(_currentValue);
    }
  }

  void _buildButtons() {
    List<Widget> buttons = [];

    if (_timer == null) {
      buttons.add(_buildButton('Start', () => _startTimer(0),
      ));
      buttons.add(_buildButton('Count Up', () => _startTimer(_currentValue),
      ));
      buttons.add(_buildButton('Count Down', () => _countDown,
      ));
      buttons.add(_buildButton('Reset', () => _resetTimer,
      ));
    } else {
      buttons.add(_buildButton('Stop', () => _stopTimer,
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
