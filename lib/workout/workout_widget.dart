import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/services/models.dart';
import 'package:wortra/state/workout_state.dart';
import 'package:wortra/workout/edit_workout.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutState = context.watch<WorkoutState>();
    Workout workout = workoutState.workout;

    return Visibility(
      maintainSize: !workout.deleted,
      maintainAnimation: !workout.deleted,
      maintainState: !workout.deleted,
      visible: !workout.deleted,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          EditWorkoutDialog(workoutState: workoutState));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(workout.workoutName),
                )),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('${workoutState.count}'),
                ),
                IconButton(
                  onPressed: workoutState.add,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: workoutState.remove,
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
