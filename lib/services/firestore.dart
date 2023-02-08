import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final _db = FirebaseFirestore.instance;

  Future<void> addUser(userId, user) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) {
      await _db.collection('users').doc(userId).set({
        ...user,
        'workouts': [],
      });
    }
  }

  Future<void> addWorkout(workoutName, increment, userId) async {
    CollectionReference ref =
        _db.collection('users').doc(userId).collection('workouts');
    DateTime now = DateTime.now();
    await ref.add({
      'workoutName': workoutName,
      'increment': int.parse(increment),
      'current': 0,
      'date': DateTime(now.year, now.month, now.day),
    });
  }

  Future<List> getWorkouts(userId) async {
    CollectionReference ref =
        _db.collection('users').doc(userId).collection('workouts');
    QuerySnapshot querySnapshot = await ref.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  Future updateWorkout(userId, workoutName, newCurrent) async {
    final ref = _db.collection('users').doc(userId);
    final doc = await ref.get();
    if (doc.exists) {
      final List workouts = doc.data()!['workouts'];
      workouts.forEach((workout) {
        if (workout['workoutName'] == workoutName) {
          workout['current'] = newCurrent;
        }
      });

      _db.collection('users').doc(userId).update({'workouts': workouts});
    }
  }
}
