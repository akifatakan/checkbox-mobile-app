import 'package:CheckBox/src/services/services.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class TodoController extends GetxController {
  var userId = ''.obs;
  var title = ''.obs;
  var note = ''.obs;
  var priority = 'Low'.obs;
  var dueDate = DateTime.now().obs;
  var category = ''.obs;
  var tags = RxList<String>();
  var attachment = ''.obs;

  final FirebaseTodoServices _todoServices = FirebaseTodoServices();

  @override
  void onInit() {
    super.onInit();
    initializeTodo();
  }

  void initializeTodo() {
    userId.value = '';
    title.value = '';
    note.value = '';
    priority.value = 'Low';
    dueDate.value = DateTime.now();
    category.value = '';
    tags.value = [];
    attachment.value = '';
  }

  void createTodo() {
    Todo todo = Todo(
        userId: userId.value,
        title: title.value,
        note: note.value,
        priority: priority.value,
        dueDate: dueDate.value,
        category: category.value,
        tags: tags.value);
    print(todo);
    _todoServices.createTodo(todo);
    initializeTodo();
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
}
