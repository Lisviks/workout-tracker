import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_widget.dart';
import 'package:wortra/state/workouts_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutsState = context.watch<WorkoutsState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView(
        key: Key(workoutsState.history.length.toString()),
        children: [HistoryWidget(history: workoutsState.history)],
      ),
    );
  }
}
