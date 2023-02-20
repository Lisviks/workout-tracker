import 'package:flutter/material.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/services/history_model.dart';
import 'package:wortra/services/models.dart';

class WorkoutsState extends ChangeNotifier {
  List<Workout> workouts = [];
  List<History> history = [];
  List<Map> workoutAverages = [];

  WorkoutsState({required this.workouts}) {
    for (var workout in workouts) {
      history.add(
          History(workoutName: workout.workoutName, history: workout.history));

      int total = 0;
      for (var num in workout.history) {
        total += num['numberDone'] as int;
      }
      String average = workout.history.isNotEmpty
          ? (total / workout.history.length).toStringAsFixed(2)
          : '0.0';
      workoutAverages
          .add({'workoutName': workout.workoutName, 'average': average});
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
      _updateAverages(workout);
    }
    notifyListeners();
  }

  void _updateAverages(workout) {
    int total = 0;
    for (var num in workout.history) {
      total += num['numberDone'] as int;
    }
    String average = workout.history.isNotEmpty
        ? (total / workout.history.length).toStringAsFixed(2)
        : '0.0';

    workoutAverages[workoutAverages.indexWhere(
            (element) => element['workoutName'] == workout.workoutName)]
        ['average'] = average;
  }
}
