import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'learning_timer_controller.dart';

class LearningTimer extends StatelessWidget {
  const LearningTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LearningTimerController(),
      builder: (context, child) => _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimerDisplay(context),
            const SizedBox(height: 20),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerDisplay(BuildContext context) {
    Duration currentDuration =
        context.watch<LearningTimerController>().currentDuration;
    String formattedTime = _formatDuration(currentDuration);
    ThemeData themeData = Theme.of(context);
    return Text(
      formattedTime,
      style: TextStyle(
        fontSize: 36,
        color: currentDuration.isNegative
            ? Colors.red
            : themeData.colorScheme.onBackground,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.abs().toString().padLeft(2, '0');
    String formattedTime =
        '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
    return duration.isNegative ? '-$formattedTime' : formattedTime;
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCountUpButton(context),
        const SizedBox(width: 20),
        _buildCountDownButton(context),
        const SizedBox(width: 20),
        _buildPauseButton(context),
        const SizedBox(width: 20),
        _buildResetButton(context),
      ],
    );
  }

  Widget _buildCountUpButton(BuildContext context) {
    LearningTimerController controller =
        context.read<LearningTimerController>();
    bool buttonActive =
        context.watch<LearningTimerController>().isCountUpButtonActive;
    return ElevatedButton(
      onPressed: buttonActive ? controller.startCountingUp : null,
      child: const Text('Count Up'),
    );
  }

  Widget _buildCountDownButton(BuildContext context) {
    LearningTimerController controller =
        context.read<LearningTimerController>();
    bool buttonActive =
        context.watch<LearningTimerController>().isCountDownButtonActive;
    return ElevatedButton(
      onPressed: buttonActive ? controller.startCountingDown : null,
      child: const Text('Count Down'),
    );
  }

  Widget _buildPauseButton(BuildContext context) {
    LearningTimerController controller =
        context.read<LearningTimerController>();
    bool buttonActive =
        context.watch<LearningTimerController>().isPauseButtonActive;
    return ElevatedButton(
      onPressed: buttonActive ? controller.pauseTimer : null,
      child: const Text('Pause'),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    LearningTimerController controller =
        context.read<LearningTimerController>();
    bool buttonActive =
        context.watch<LearningTimerController>().isResetButtonActive;
    return ElevatedButton(
      onPressed: buttonActive ? controller.resetTimer : null,
      child: const Text('Reset'),
    );
  }
}
