import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

class WorkoutWidget extends StatefulWidget {
  const WorkoutWidget({
    super.key,
    required this.workoutName,
    required this.increment,
  });

  final String workoutName;
  final int increment;

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  int count = 0;

  Future<void> add() async {
    await DB().updateWorkout(
        AuthService().user!.uid, widget.workoutName, count + widget.increment);
    setState(() {
      count += widget.increment;
    });
  }

  Future<void> remove() async {
    await DB().updateWorkout(
        AuthService().user!.uid, widget.workoutName, count - widget.increment);
    setState(() {
      count -= widget.increment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.workoutName),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('$count'),
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
