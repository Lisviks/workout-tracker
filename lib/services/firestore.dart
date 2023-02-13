import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/models.dart';

class DB {
  final _db = FirebaseFirestore.instance;

  Future<void> addUser(userId, user) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) {
      await _db.collection('users').doc(userId).set({...user});
    }
  }

  Future<void> addWorkout(workoutName, increment, userId) async {
    CollectionReference ref = _db.collection('workouts');
    DateTime now = DateTime.now();
    await ref.add({
      'userId': userId,
      'workoutName': workoutName,
      'increment': int.parse(increment),
      'current': 0,
      'date': DateTime(now.year, now.month, now.day),
      'deleted': false,
      'history': [],
    });
  }

  Future<List<Workout>> getWorkouts(userId) async {
    var ref = _db.collection('workouts');
    await _updateHistory(userId, ref);
    var snapshot = await ref.where('userId', isEqualTo: userId).get();
    var data = snapshot.docs.map((doc) {
      var workout = doc.data();
      workout['id'] = doc.id;
      return workout;
    });
    var workouts = data.map((d) => Workout.fromJson({
          ...d,
          'date': d['date'].toDate().toString(),
        }));

    return workouts.toList();
  }

  Future<void> updateWorkout(workoutId, workoutName, newCurrent) async {
    var ref = _db.collection('workouts').doc(workoutId);
    await ref.update({'current': newCurrent});
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
  }

  Future<List> getHistory(userId) async {
    CollectionReference workoutsRef =
        _db.collection('users').doc(userId).collection('workouts');
    QuerySnapshot querySnapshot = await workoutsRef.get();
    final List<Future> allHistory = querySnapshot.docs.map((doc) async {
      var workout = doc.data() as Map;
      workout['id'] = doc.id;
      CollectionReference historyRef =
          workoutsRef.doc(workout['id']).collection('history');
      QuerySnapshot historySnapshot =
          await historyRef.orderBy('date', descending: true).get();
      final history = historySnapshot.docs.map((doc) {
        return doc.data() as Map;
      }).toList();
      workout['history'] = history;
      return workout;
    }).toList();
    final result = await Future.wait(allHistory);
    return result;
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
