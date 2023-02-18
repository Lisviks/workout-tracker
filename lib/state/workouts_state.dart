import 'package:flutter/material.dart';
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
}
