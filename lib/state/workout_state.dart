import 'package:flutter/material.dart';
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
    await DB().updateWorkout(workout.id, count);
    notifyListeners();
  }

  Future<void> remove() async {
    count -= workout.increment;
    await DB().updateWorkout(workout.id, count);
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

  Future<void> deleteWorkout({required id, deleted = false}) async {
    await DB().deleteWorkout(id, deleted);
    workout.deleted = true;
    notifyListeners();
  }
}
