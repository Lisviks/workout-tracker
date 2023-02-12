import 'package:flutter/material.dart';

class HistoryState extends ChangeNotifier {
  late Map history;
  bool isOpen = false;

  HistoryState({required this.history});

  void toggleList() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
