import 'package:cloud_firestore/cloud_firestore.dart';
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
    var ref = _db.collection('workouts');
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
    await _updateHistory(userId);
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

  Future<void> updateWorkout(workoutId, newCurrent) async {
    var ref = _db.collection('workouts').doc(workoutId);
    await ref.update({'current': newCurrent});
  }

  Future<void> editWorkout(id, workoutName, increment) async {
    var ref = _db.collection('workouts').doc(id);
    await ref.update({'workoutName': workoutName, 'increment': increment});
  }

  Future<void> deleteWorkout(id, deleted) async {
    var ref = _db.collection('workouts').doc(id);
    if (deleted) {
      await ref.delete();
    } else {
      await ref.update({'deleted': true});
    }
  }

  Future<void> deleteHistory(id) async {
    var ref = _db.collection('workouts').doc(id);
    await ref.update({'history': []});
  }

  Future<void> _updateHistory(userId) async {
    var ref = _db.collection('workouts');
    var snapshot = await ref.where('userId', isEqualTo: userId).get();
    final workouts = snapshot.docs.map((doc) {
      var workout = doc.data();
      workout['id'] = doc.id;
      return workout;
    }).toList();

    DateTime now = DateTime.now();

    for (var workout in workouts) {
      int currentDay = now.day;
      int workoutDay = DateTime.parse(workout['date'].toDate().toString()).day;

      if (currentDay > workoutDay && !workout['deleted']) {
        var docRef = ref.doc(workout['id']);
        var doc = await docRef.get();
        var data = doc.data() as Map;
        List history = data['history'];
        history.add({
          'date': data['date'],
          'numberDone': workout['current'],
        });

        await docRef.update({
          'history': history,
          'date': DateTime(now.year, now.month, now.day),
          'current': 0,
        });
      }
    }
  }
}
