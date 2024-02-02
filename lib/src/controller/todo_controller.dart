import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/services/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class TodoController extends GetxController {
  final FirebaseTodoServices _todoServices = FirebaseTodoServices();
  final UserController _userController = Get.find<UserController>();

  var userId = ''.obs;
  var title = ''.obs;
  var note = ''.obs;
  var priority = 'Low'.obs;
  var dueDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var category = 'Work'.obs;
  var tags = <String>[].obs;
  var attachment = ''.obs;

  var isFetched = false.obs;

  //for todoList
  var todos = RxList<Todo>();

  //for todoDetails
  var isEditMode = false.obs;

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  @override
  void onInit() {
    super.onInit();
    initializeTodo();
  }

  void toggleTag(String tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
  }

  void clearSelectedTags() {
    tags.clear();
  }

  void initializeTodo() {
    userId.value = '';
    title.value = '';
    note.value = '';
    priority.value = 'Low';
    dueDate.value =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    category.value = 'Work';
    tags.value = [];
    attachment.value = '';
  }

  void createTodo() async {
    Todo todo = Todo(
        userId: userId.value,
        title: title.value,
        note: note.value,
        priority: priority.value,
        dueDate: dueDate.value,
        category: category.value,
        tags: tags,
        status: 'active');
    await _todoServices.createTodo(todo);
    initializeTodo();
  }

  void updateTodo(String todoId) async {
    Todo? oldTodo = await _todoServices.getTodoById(todoId);
    Todo todo = Todo(
        id: todoId,
        userId: userId.value,
        title: title.value,
        note: note.value,
        priority: priority.value,
        dueDate: dueDate.value,
        category: category.value,
        tags: tags.value,
        status: oldTodo!.status);
    await _todoServices.updateTodo(todo);
    initializeTodo();
  }

  void editTodo(Todo todo) async {
    await _todoServices.updateTodo(todo);
  }

  void addTag(String tag) {
    tags.add(tag);
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void setTagsFromString(String tagString) {
    List<String> tagList =
        tagString.split(',').map((tag) => tag.trim()).toList();
    tags.assignAll(tagList);
  }

  void fetchTodos(String userId) async {
    isFetched.value = false;
    todos.value = await _todoServices.getTodosFromFirestore(userId);
    filterPassedTodos();
    todos.value = _groupAndSortTodos(todos.value);
    isFetched.value = true;
  }

  void filterPassedTodos() {
    DateTime today = DateTime.now();
    todos.value = todos.value.where((todo) {
      return todo.dueDate
          .isAfter(DateTime(today.year, today.month, today.day - 1));
    }).toList();
  }

  List<Todo> _groupAndSortTodos(List<Todo> todos) {
    const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};

    // Sort by due date and then by priority
    todos.sort((a, b) {
      int dateCompare = a.dueDate.compareTo(b.dueDate);
      if (dateCompare != 0) {
        return dateCompare;
      }
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });

    return todos;
  }

  Future<void> deleteTodoOfUserByID(String userId, String todoId) async {
    await _todoServices.deleteTodo(todoId);
    fetchTodos(userId);
  }

  Future<void> markTodoAsComplete(String userId, String todoId) async {
    Todo? todo = await _todoServices.getTodoById(todoId);
    todo!.status = 'complete';
    _todoServices.updateTodo(todo);
  }

  Future<Todo> getTodoByID(String todoId) async {
    Todo? todo = await _todoServices.getTodoById(todoId);
    return todo!;
  }
}
