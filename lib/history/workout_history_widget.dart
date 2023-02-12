import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_state.dart';

class WorkoutHistoryWidget extends StatelessWidget {
  const WorkoutHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryState>();
    Map history = historyState.history;
    return Text("${history['workoutName']}");
  }
}
