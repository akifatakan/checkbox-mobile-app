import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../controller/controller.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final UserController _userController = Get.find<UserController>();
  final TodoController _todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todoController.fetchTodos(_userController.user.value!.id);
    });
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: CustomAppBar(
        title: 'CheckBox',
        actions: [
          IconButton(
            onPressed: () {
              _todoController.fetchTodos(_userController.user.value!.id);
            },
            icon: Icon(Icons.refresh),
          ),
          Obx(() {
            if (_userController.isUserSignedIn.value) {
              return IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => {
                  _userController.signOut(),
                  Get.offAllNamed(Routes.welcome)
                },
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
      body: Center(
        child: Obx(
          () => !_todoController.isFetched.value ? CircularProgressIndicator() : TodoListSection(
            todos: _todoController.todos.value,
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
