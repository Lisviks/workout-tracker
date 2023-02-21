class History {
  final String workoutName;
  final List history;
  bool isExpanded;

  History({
    required this.workoutName,
    required this.history,
    this.isExpanded = false,
  });
}
