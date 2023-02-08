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
    final data = querySnapshot.docs.map((doc) {
      _updateHistory(doc.data(), doc.id, userId);
      return doc.data();
    }).toList();
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

  Future<void> _updateHistory(workout, docId, userId) async {
    CollectionReference workoutsRef =
        _db.collection('users').doc(userId).collection('workouts');
    DocumentReference workoutDocRef = workoutsRef.doc(docId);
    DocumentSnapshot workoutDoc = await workoutDocRef.get();
    var workoutData = workoutDoc.data() as Map<String, dynamic>;

    int currentDay = DateTime.now().day;
    int workoutDay =
        DateTime.parse(workoutData['date'].toDate().toString()).day;

    DateTime now = DateTime.now();

    if (currentDay > workoutDay) {
      await workoutDocRef.update({
        'date': DateTime(now.year, now.month, now.day),
        'current': 0,
      });
      CollectionReference historyRef = _db
          .collection('users')
          .doc(userId)
          .collection('workouts')
          .doc(docId)
          .collection('history');

      await historyRef.doc().set({
        'date': workoutData['date'],
        'numberDone': workoutData['current'],
      });
    }
  }
}
