import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/shared/bottom_nav.dart';
import 'package:wortra/workout/workout_widget.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _workouts = DB().getWorkouts(AuthService().user!.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _workouts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!
                    .map<Widget>(
                      (workout) => WorkoutWidget(workout: workout),
                    )
                    .toList(),
              );
            }
            return const Text('No workouts');
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_workout'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
