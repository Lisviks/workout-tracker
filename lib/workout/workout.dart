import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/services/models.dart';
import 'package:wortra/shared/bottom_nav.dart';
import 'package:wortra/state/workout_state.dart';
import 'package:wortra/workout/workout_widget.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  Future<List<Workout>> init() async {
    return await DB().getWorkouts(AuthService().user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Tracker')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  ...snapshot.data!
                      .map<Widget>(
                        (workout) => ChangeNotifierProvider(
                            create: (context) => WorkoutState(workout: workout),
                            child: const WorkoutWidget()),
                      )
                      .toList(),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/add_workout'),
                      child: const Text('Add Workout'))
                ],
              );
            }
            return const Text('No workouts');
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
