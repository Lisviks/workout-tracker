import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Workout {
  final String id;
  final int current;
  final DateTime date;
  final bool deleted;
  final int increment;
  final String workoutName;

  Workout(
      {this.id = '',
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
