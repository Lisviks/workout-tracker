import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Workout {
  final String userId;
  final String id;
  final int current;
  final DateTime date;
  late List history;
  bool deleted;
  int increment;
  String workoutName;

  Workout(
      {this.userId = '',
      this.id = '',
      this.current = 0,
      DateTime? date,
      this.deleted = false,
      this.increment = 0,
      this.workoutName = ''})
      : date = date ?? DateTime.now();

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
