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
                children: snapshot.data
                    .map<Widget>((workout) => WorkoutWidget(
                          workoutName: workout['workoutName'],
                        ))
                    .toList(),
              );
            }
            return const Text('No workouts');
          },
        ),
        // child: Column(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         const Text('Pushups'),
        //         Row(
        //           children: [
        //             const Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 10.0),
        //               child: Text('10'),
        //             ),
        //             IconButton(
        //               onPressed: () {},
        //               icon: const Icon(
        //                 Icons.add,
        //                 color: Colors.blue,
        //               ),
        //             ),
        //             IconButton(
        //               onPressed: () {},
        //               icon: const Icon(
        //                 Icons.remove,
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         const Text('Crunches'),
        //         Row(
        //           children: [
        //             const Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 10.0),
        //               child: Text('10'),
        //             ),
        //             IconButton(
        //               onPressed: () {},
        //               icon: const Icon(
        //                 Icons.add,
        //                 color: Colors.blue,
        //               ),
        //             ),
        //             IconButton(
        //               onPressed: () {},
        //               icon: const Icon(
        //                 Icons.remove,
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_workout'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
