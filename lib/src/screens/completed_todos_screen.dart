import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/widgets.dart';

class CompletedTodosScreen extends StatelessWidget {
  CompletedTodosScreen({Key? key}) : super(key: key);

  final TodoController _todoController = Get.find<TodoController>();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todoController.fetchCompletedTodos(_userController.user.value!.id);
    });
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: CustomAppBar(
        title: 'Completed Todos',
        actions: [
          IconButton(
            onPressed: () async {
              await _todoController
                  .fetchCompletedTodos(_userController.user.value!.id);
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () => !_todoController.isFetched.value
              ? CircularProgressIndicator()
              : TodoListSection(
                  todos: _todoController.completedTodos.value,
                  onDismiss: (Todo todo, DismissDirection direction) async {
                    if (direction == DismissDirection.endToStart) {
                      // Handle the deletion logic for swipe left
                      await _todoController.deleteTodoOfUserByID(
                          _userController.user.value!.id, todo.id!);
                    } else if (direction == DismissDirection.startToEnd) {
                      // Handle marking todo as complete for swipe right
                      await _todoController.markTodoAsComplete(
                          _userController.user.value!.id, todo.id!);
                    }
                  },
                ),
        ),
      ),
    );
  }
}
