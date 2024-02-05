import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

Map<String, List<Todo>> groupTodosForDisplay(List<Todo> todos) {
  var grouped = <String, List<Todo>>{};
  for (var todo in todos) {
    String dueDateKey = DateFormat('yyyy-MM-dd').format(todo.dueDate);
    grouped.putIfAbsent(dueDateKey, () => []).add(todo);
  }
  return grouped;
}

class PriorityIndicator extends StatelessWidget {
  final String priority;

  const PriorityIndicator({Key? key, required this.priority})
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
