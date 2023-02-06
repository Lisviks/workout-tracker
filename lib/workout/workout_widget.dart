import 'package:flutter/material.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({super.key, required this.workoutName});

  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(workoutName),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('10'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove,
                color: Colors.blue,
              ),
            ),
          ],
        )
      ],
    );
  }
}
