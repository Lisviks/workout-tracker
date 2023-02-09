import 'package:flutter/material.dart';

class WorkoutState extends ChangeNotifier {
  late Map<String, dynamic> workout;
  int count = 0;

  WorkoutState({required this.workout});

  void add() {
    count += 10;
    notifyListeners();
  }

  void remove() {
    count -= 10;
    notifyListeners();
  }
}
