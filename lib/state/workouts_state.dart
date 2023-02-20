import 'package:flutter/material.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/services/history_model.dart';
import 'package:wortra/services/models.dart';

class WorkoutsState extends ChangeNotifier {
  List<Workout> workouts = [];
  List<History> history = [];

  WorkoutsState({required this.workouts}) {
    for (var workout in workouts) {
      history.add(
          History(workoutName: workout.workoutName, history: workout.history));
    }
  }

  Future<void> deleteHistory(historyToRemove) async {
    int workoutIndex = workouts.indexWhere(
        ((element) => element.workoutName == historyToRemove.workoutName));
    Workout workout = workouts
        .where((item) => item.workoutName == historyToRemove.workoutName)
        .toList()[0];
    if (workout.deleted) {
      await DB().deleteWorkout(workout.id, workout.deleted);
      history.remove(historyToRemove);
    } else {
      await DB().deleteHistory(workout.id);
      workouts[workoutIndex].history = [];
    }
    notifyListeners();
  }
}
