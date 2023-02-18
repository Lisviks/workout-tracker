import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_state.dart';
import 'package:wortra/history/workout_history_widget.dart';
import 'package:wortra/state/workouts_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutState = context.watch<WorkoutsState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView(
        children: [
          ...workoutState.history
              .map<Widget>(
                (workout) => ChangeNotifierProvider(
                    create: (context) => HistoryState(history: workout),
                    child: const WorkoutHistoryWidget()),
              )
              .toList(),
        ],
      ),
    );
  }
}
