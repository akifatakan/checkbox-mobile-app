class User {
  final String id;
  final String email;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });

  // Converts a User object into a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }

  // Creates a User object from a map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  // Copy method for updating instance immutably.
  User copyWith({
    String? id,
    String? email,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username}';
  }
}
