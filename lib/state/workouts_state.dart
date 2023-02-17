import 'package:flutter/material.dart';
import 'package:wortra/services/models.dart';

class WorkoutsState extends ChangeNotifier {
  List<Workout> workouts = [];
  List history = [];

  WorkoutsState({required this.workouts});

  List getHistory() {
    List history = [];

    for (var workout in workouts) {
      history.add(
          {'workoutName': workout.workoutName, 'history': workout.history});
    }

    return history;
  }
}
