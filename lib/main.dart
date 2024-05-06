import 'package:flutter/material.dart';
import 'package:learning_timer/refined_chat_gpt_learning_timer.dart';

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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const RefinedChatGptLearningTimer(),
    );
  }
}

