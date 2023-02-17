import 'package:flutter/material.dart';
import 'package:wortra/services/models.dart';

class WorkoutsState extends ChangeNotifier {
  List<Workout> workouts = [];

  WorkoutsState({required this.workouts});
}
