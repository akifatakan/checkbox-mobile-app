import 'package:CheckBox/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<List<Todo>> getTodosFromFirestore(String userId) async {
    QuerySnapshot querySnapshot =
        await _todoCollection.where('userId', isEqualTo: userId).where('status', isEqualTo: 'active').get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Include the document ID
      return Todo.fromJson(data);
    }).toList();
  }
}
