import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numerix/models/history_item.dart';

// Yeh class Cloud Firestore database se data save/retrieve karne ka kaam karti hai.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User ki settings ko save ya update karne ke liye.
  Future<void> saveUserSettings(String userId, Map<String, dynamic> settings) async {
    try {
      // User ke document reference ko get karke usmein settings merge kar rahe hain.
      await _db.collection('users').doc(userId).set(
        {'settings': settings},
        SetOptions(merge: true), // merge: true se purana data delete nahi hoga.
      );
    } catch (e) {
      print(e);
    }
  }

  // User ki history ko save karne ke liye.
  Future<void> saveHistoryItem(String userId, HistoryItem item) async {
    try {
      // User ke andar ek 'history' sub-collection mein naya item add kar rahe hain.
      await _db
          .collection('users')
          .doc(userId)
          .collection('history')
          .add(item.toMap());
    } catch (e) {
      print(e);
    }
  }

  // User ki poori history get karne ke liye ek stream.
  Stream<List<HistoryItem>> getHistoryStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HistoryItem.fromMap(doc.data()))
            .toList());
  }
}
