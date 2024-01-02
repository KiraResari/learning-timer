import 'package:flutter/material.dart';

import 'bard_learning_timer.dart';
import 'chat_gpt_learning_timer.dart';
import 'flutter_bard_learning_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Timer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ChatGptLearningTimer(),
    );
  }
}

