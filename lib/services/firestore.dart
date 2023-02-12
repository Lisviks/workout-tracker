import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wortra/services/auth.dart';

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
      'deleted': false,
    });
  }

  Future<List> getWorkouts(userId) async {
    CollectionReference ref =
        _db.collection('users').doc(userId).collection('workouts');
    await _updateHistory(userId, ref);
    QuerySnapshot querySnapshot = await ref.get();
    final data = querySnapshot.docs.map((doc) {
      var workout = doc.data() as Map;
      workout['id'] = doc.id;
      return workout;
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

  Future<void> editWorkout(id, workoutName, increment) async {
    String userId = AuthService().user!.uid;
    DocumentReference docRef =
        _db.collection('users').doc(userId).collection('workouts').doc(id);

    await docRef.update({'workoutName': workoutName, 'increment': increment});
  }

  Future<void> deleteWorkout(id) async {
    String userId = AuthService().user!.uid;
    DocumentReference docRef =
        _db.collection('users').doc(userId).collection('workouts').doc(id);

    await docRef.update({'deleted': true});

    // await docRef.delete();
  }

  Future<void> _updateHistory(userId, workoutRef) async {
    QuerySnapshot querySnapshot = await workoutRef.get();
    final workouts = querySnapshot.docs.map((doc) {
      var workout = doc.data() as Map;
      workout['id'] = doc.id;
      return workout;
    }).toList();

    DateTime now = DateTime.now();

    for (var workout in workouts) {
      int currentDay = now.day;
      int workoutDay = DateTime.parse(workout['date'].toDate().toString()).day;

      if (currentDay > workoutDay && !workout['deleted']) {
        CollectionReference workoutsRef =
            _db.collection('users').doc(userId).collection('workouts');
        DocumentReference workoutDocRef = workoutsRef.doc(workout['id']);

        await workoutDocRef.update(
          {
            'date': DateTime(now.year, now.month, now.day),
            'current': 0,
          },
        );

        CollectionReference historyRef = _db
            .collection('users')
            .doc(userId)
            .collection('workouts')
            .doc(workout['id'])
            .collection('history');

        await historyRef.doc().set({
          'date': workout['date'],
          'numberDone': workout['current'],
        });
      }
    }
  }
}
