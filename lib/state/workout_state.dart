import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/services/models.dart';

class WorkoutState extends ChangeNotifier {
  late Workout workout;
  int count = 0;

  WorkoutState({required this.workout}) {
    count = workout.current;
  }

  Future<void> add() async {
    count += workout.increment;
    await DB().updateWorkout(workout.id, workout.workoutName, count);
    notifyListeners();
  }

  Future<void> remove() async {
    count -= workout.increment;
    await DB().updateWorkout(workout.id, workout.workoutName, count);
    notifyListeners();
  }

  Future<void> editWorkout(workoutName, increment) async {
    if (workout.workoutName != workoutName || workout.increment != increment) {
      workout.workoutName = workoutName;
      workout.increment = increment;
      await DB().editWorkout(
        workout.id,
        workoutName,
        increment,
      );
      notifyListeners();
    }
  }

  Future<void> deleteWorkout(id) async {
    await DB().deleteWorkout(id);
    workout.deleted = true;
    notifyListeners();
  }
}
