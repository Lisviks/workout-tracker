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
}
