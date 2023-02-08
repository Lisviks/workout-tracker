import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final _db = FirebaseFirestore.instance;

  Future<void> addUser(userId, user) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) {
      await _db.collection('users').doc(userId).set({...user});
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

  Future<void> updateWorkout(userId, workoutName, newCurrent) async {
    Query queryByWorkoutName = _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .where('workoutName', isEqualTo: workoutName);
    QuerySnapshot querySnapshot = await queryByWorkoutName.get();
    String workoutId = '';
    for (var doc in querySnapshot.docs) {
      workoutId = doc.id;
    }
    CollectionReference ref =
        _db.collection('users').doc(userId).collection('workouts');
    DocumentReference doc = ref.doc(workoutId);
    doc.update({'current': newCurrent});
  }
}
