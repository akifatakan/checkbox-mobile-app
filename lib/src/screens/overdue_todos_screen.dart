import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/widgets.dart';

class OverdueTodosScreen extends StatelessWidget {
  OverdueTodosScreen({Key? key}) : super(key: key);

  final TodoController _todoController = Get.find<TodoController>();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todoController.fetchOverdueTodos(_userController.user.value!.id);
    });
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: CustomAppBar(
        title: 'Overdue Todos',
        actions: [
          IconButton(
            onPressed: () async {
              await _todoController
                  .fetchOverdueTodos(_userController.user.value!.id);
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
            todos: _todoController.overdueTodos.value,
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
