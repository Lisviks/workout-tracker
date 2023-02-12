import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

class WorkoutState extends ChangeNotifier {
  late Map<String, dynamic> workout;
  int count = 0;

  WorkoutState({required this.workout}) {
    count = workout['current'];
  }

  Future<void> add() async {
    count += workout['increment'] as int;
    await DB()
        .updateWorkout(AuthService().user!.uid, workout['workoutName'], count);
    notifyListeners();
  }

  Future<void> remove() async {
    count -= workout['increment'] as int;
    await DB()
        .updateWorkout(AuthService().user!.uid, workout['workoutName'], count);
    notifyListeners();
  }

  Future<void> editWorkout(workoutName, increment) async {
    if (workout['workoutName'] != workoutName ||
        workout['increment'] != increment) {
      workout['workoutName'] = workoutName;
      workout['increment'] = increment;
      await DB().editWorkout(
        workout['id'],
        workoutName,
        increment,
      );
      notifyListeners();
    }
  }

  Future<void> deleteWorkout(id) async {
    await DB().deleteWorkout(id);
    workout['deleted'] = true;
    notifyListeners();
  }
}
