import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  String? id;
  String userId;
  String title;
  String note;
  String priority;
  DateTime dueDate;
  String category;
  List<String> tags;
  String? attachment; // Optional attachment (could be a file path or URL)

  Todo({
    this.id,
    required this.userId,
    required this.title,
    required this.note,
    required this.priority,
    required this.dueDate,
    required this.category,
    required this.tags,
    this.attachment,
  });

  // Convert a Todo object into a map.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'note': note,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'category': category,
      'tags': tags,
      'attachment': attachment,
    };
  }

  // Create a Todo object from a map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      note: json['note'],
      priority: json['priority'],
      dueDate: DateTime.parse(json['dueDate']),
      category: json['category'],
      tags: List<String>.from(json['tags']),
      attachment: json['attachment'],
    );
  }

  factory Todo.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Todo(
      id: snapshot.id ?? '',
      userId: snapshot['userId'] ?? '',
      title: snapshot['title'] ?? '',
      note: snapshot['note'] ?? '',
      priority: snapshot['priority'] ?? '',
      dueDate: DateTime.parse(snapshot['dueDate']),
      category: snapshot['category'] ?? '',
      tags: List<String>.from(snapshot['tags']),
      attachment: snapshot['attachment'],
    );
  }
  @override
  String toString() {
    return 'id: $id\nuserId: $userId\ntitle: $title\nnote: $note\npriority: $priority\ndueDate: ${DateFormat('yyyy-MM-dd').format(dueDate)}\ncategory: $category\n tags: ${tags.toString()}\nattachment: ${attachment ?? ''}';
  }
}