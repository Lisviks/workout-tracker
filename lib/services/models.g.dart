// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      id: json['id'] as String? ?? '',
      current: json['current'] as int? ?? 0,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      deleted: json['deleted'] as bool? ?? false,
      increment: json['increment'] as int? ?? 0,
      workoutName: json['workoutName'] as String? ?? '',
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'current': instance.current,
      'date': instance.date.toIso8601String(),
      'deleted': instance.deleted,
      'increment': instance.increment,
      'workoutName': instance.workoutName,
    };
