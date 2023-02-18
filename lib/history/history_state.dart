import 'package:flutter/material.dart';
import 'package:wortra/services/history_model.dart';

class HistoryState extends ChangeNotifier {
  late History history;
  bool isOpen = false;

  HistoryState({required this.history});

  void toggleList() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
