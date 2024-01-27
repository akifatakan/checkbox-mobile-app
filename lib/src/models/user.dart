import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String displayName;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
  });

  // Converts a User object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'displayName': displayName
    };
  }

  // Creates a User object from a map (JSON).
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      displayName: json['displayName'] ?? '',
    );
  }

  // Creates a User object from a DocumentSnapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      displayName: data['displayName'] ?? '',
    );
  }

  // Copy method for updating instance immutably.
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
  }) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        displayName: displayName ?? this.displayName);
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, displayName: $displayName}';
  }
}
