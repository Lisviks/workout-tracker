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
    final ref = _db.collection('users').doc(userId);
    final doc = await ref.get();
    if (doc.exists) {
      _db.collection('users').doc(userId).update({
        'workouts': FieldValue.arrayUnion([
          {'workoutName': workoutName, 'increment': int.parse(increment)}
        ])
      });
    }
  }

  Future getWorkouts(userId) async {
    final ref = _db.collection('users').doc(userId);
    final doc = await ref.get();
    if (doc.exists) {
      return doc.data()!['workouts'];
    }
  }
}
