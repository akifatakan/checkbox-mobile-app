import 'package:CheckBox/src/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      appBar: CustomAppBar(
        title: 'CheckBox',
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Get.toNamed(Routes.createTodo);
              // Action when the add icon is pressed
            },
          ),
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
        child: TodoListSection(),
      ),
    );
  }
}

class TodoListSection extends StatelessWidget {
  TodoController todoController = Get.find<TodoController>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!todoController.isFetched.value) {
        return CircularProgressIndicator();
      }
      if (todoController.todos.isEmpty) {
        return Center(child: Text('No TODOs found'));
      }

      // Group TODOs by due date for display
      var groupedTodos = groupTodosForDisplay(todoController.todos);
      return ListView.builder(
        itemCount: groupedTodos.length,
        itemBuilder: (context, index) {
          String dueDateKey = groupedTodos.keys.elementAt(index);
          List<Todo> todosForDate = groupedTodos[dueDateKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  dueDateKey,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...todosForDate.map(
                (todo) => Dismissible(
                  key: Key(todo.id!),
                  // Ensure each Dismissible has a unique key
                  background: Container(
                    color: Colors.green,
                    // Color indicating completion
                    alignment: Alignment.centerLeft,
                    // Align to the left for swipe right action
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.check,
                        color: Colors.white), // Icon indicating completion
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    // Color indicating deletion
                    alignment: Alignment.centerRight,
                    // Align to the right for swipe left action
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete,
                        color: Colors.white), // Icon indicating deletion
                  ),
                  direction: DismissDirection.horizontal,
                  // Enable swiping in both directions
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // Handle the deletion logic for swipe left
                      todoController.deleteTodoOfUserByID(
                          userController.user.value!.id, todo.id!);
                    } else if (direction == DismissDirection.startToEnd) {
                      // Handle marking todo as complete for swipe right
                      todoController.markTodoAsComplete(
                          userController.user.value!.id, todo.id!);
                    }
                  },
                  child: CustomTodoTile(todo: todo),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

class CustomTodoTile extends StatelessWidget {
  final Todo todo;

  const CustomTodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => TodoDetailsScreen(todo: todo));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                todo.note,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(todo.dueDate),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  _PriorityIndicator(priority: todo.priority),
                  // Add actions (like edit, delete) here if needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  final String priority;

  const _PriorityIndicator({Key? key, required this.priority})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.amber;
        break;
      default:
        color = Colors.green;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

Map<String, List<Todo>> groupTodosForDisplay(List<Todo> todos) {
  var grouped = <String, List<Todo>>{};
  for (var todo in todos) {
    String dueDateKey = DateFormat('yyyy-MM-dd').format(todo.dueDate);
    grouped.putIfAbsent(dueDateKey, () => []).add(todo);
  }
  return grouped;
}
