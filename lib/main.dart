import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'bard_learning_timer.dart';
import 'chat_gpt_learning_timer.dart';
import 'refined_chat_gpt_learning_timer.dart';
import 'flutter_bard_learning_timer.dart';
import 'learning_timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hotKeyManager.unregisterAll();
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
      home: const LearningTimer(),
    );
  }
}
