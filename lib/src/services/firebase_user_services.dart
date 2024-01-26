import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class FirebaseUserServices {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Create a new user document
  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.id).set(user.toJson());
  }

  // Read (get) a user by ID
  Future<UserModel?> getUserById(String userId) async {
    DocumentSnapshot doc = await _userCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromSnapshot(doc);
    }
    return null;
  }

  // Update an existing user
  Future<void> updateUser(UserModel user) async {
    await _userCollection.doc(user.id).update(user.toJson());
  }

  // Delete a user by ID
  Future<void> deleteUser(String userId) async {
    await _userCollection.doc(userId).delete();
  }
}
