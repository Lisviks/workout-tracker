// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      userId: json['userId'] as String? ?? '',
      id: json['id'] as String? ?? '',
      current: json['current'] as int? ?? 0,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      deleted: json['deleted'] as bool? ?? false,
      increment: json['increment'] as int? ?? 0,
      workoutName: json['workoutName'] as String? ?? '',
    )..history = json['history'] as List<dynamic>;

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'current': instance.current,
      'date': instance.date.toIso8601String(),
      'history': instance.history,
      'deleted': instance.deleted,
      'increment': instance.increment,
      'workoutName': instance.workoutName,
    };
