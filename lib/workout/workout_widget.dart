import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

class WorkoutWidget extends StatefulWidget {
  const WorkoutWidget({super.key, required this.workout});

  final Map<String, dynamic> workout;

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  int count = 0;

  Future<int> initCount() async {
    List workouts = await DB().getWorkouts(AuthService().user!.uid);
    var workout = workouts
        .where((item) => item['workoutName'] == widget.workout['workoutName'])
        .toList()[0];
    return workout['current'];
  }

  Future<void> add() async {
    await DB().updateWorkout(AuthService().user!.uid,
        widget.workout['workoutName'], count + widget.workout['increment']);
    setState(() {
      count += widget.workout['increment'] as int;
    });
  }

  Future<void> remove() async {
    await DB().updateWorkout(AuthService().user!.uid,
        widget.workout['workoutName'], count - widget.workout['increment']);
    setState(() {
      count -= widget.workout['increment'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.workout['workoutName']),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FutureBuilder(
                  future: initCount(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      count = snapshot.data as int;
                      return Text('${snapshot.data}');
                    } else {
                      return const Text('0');
                    }
                  }),
            ),
            IconButton(
              onPressed: add,
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: remove,
              icon: const Icon(
                Icons.remove,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
