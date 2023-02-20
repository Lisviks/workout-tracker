import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/services/models.dart';
import 'package:wortra/state/workout_state.dart';
import 'package:wortra/workout/workout_widget.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.workouts});

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Tracker')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: [
            ...workouts
                .map<Widget>(
                  (workout) => ChangeNotifierProvider(
                      create: (context) => WorkoutState(workout: workout),
                      child: const WorkoutWidget()),
                )
                .toList(),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/add_workout'),
                child: const Text('Add Workout'))
          ],
        ),
      ),
    );
  }
}
