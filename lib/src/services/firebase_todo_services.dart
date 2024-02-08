import 'dart:io';

import 'package:CheckBox/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseTodoServices {
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> createTodo(Todo todo) async {
    List<String> tags = todo.tags;
    DocumentReference docRef = await _todoCollection.add(todo.toJson());
    todo.id = docRef.id;
    todo.tags = tags;
    //await updateTodo(todo);
  }

  // Read (get) a todo by ID
  Future<Todo?> getTodoById(String todoId) async {
    DocumentSnapshot doc = await _todoCollection.doc(todoId).get();
    if (doc.exists) {
      return Todo.fromSnapshot(doc);
    }
    return null;
  }

  // Update an existing todo
  Future<void> updateTodo(Todo todo) async {
    await _todoCollection.doc(todo.id).update(todo.toJson());
  }

  // Delete a todo by ID
  Future<void> deleteTodo(String todoId) async {
    await _todoCollection.doc(todoId).delete();
  }

  Future<List<Todo>> getTodosFromFirestoreByStatus(
      String userId, String status) async {
    QuerySnapshot querySnapshot = await _todoCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Include the document ID
      return Todo.fromJson(data);
    }).toList();
  }

  Future<String?> uploadFile(File file) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + file.path;
      if (fileName.split('/').last.startsWith('image_picker_')) {
        fileName = fileName.split('/').first + '-' + fileName.split('/').last;
      } else {
        fileName = fileName.split('/').first +
            '-file_picker_' +
            fileName.split('/').last;
      }
      Reference ref =
          FirebaseStorage.instance.ref().child('todo_attachments/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteImageFromFirebase(String fileUrl) async {
    try {
      // Decode the URL
      String decodedUrl = Uri.decodeFull(Uri.parse(fileUrl).path);

      // Extract the file name from the decoded URL
      String fileName = decodedUrl.split('/').last;

      // Create a reference to the file to delete
      Reference storageRef =
          FirebaseStorage.instance.ref('todo_attachments/$fileName');

      // Delete the file
      await storageRef.delete();
    } catch (e) {
      print("Error deleting file: $e");
    }
  }
}
