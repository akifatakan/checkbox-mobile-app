import 'package:flutter/material.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import 'widgets.dart';

class TodoListSection extends StatelessWidget {
  const TodoListSection({
    Key? key,
    this.onDismiss,
    required this.todos,
  }) : super(key: key);

  final Function(Todo todo, DismissDirection direction)? onDismiss;
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(child: Text('No TODOs found'));
    }

    // Group TODOs by due date for display
    var groupedTodos = groupTodosForDisplay(todos);
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
            ...todosForDate.map((todo) => CustomTodoTile(todo: todo, onDismiss: onDismiss,),
            ),
          ],
        );
      },
    );
  }
}
