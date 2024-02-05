import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class CustomTodoTile extends StatelessWidget {
  final Todo todo;
  final Function(Todo todo, DismissDirection direction)? onDismiss;

  const CustomTodoTile({Key? key, required this.todo, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id!),
      background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.check, color: Colors.white)),
      secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.delete, color: Colors.white)),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (onDismiss != null) {
          onDismiss?.call(todo,
              direction); // Correctly pass todo and direction to onDismiss.
        }
      },
      child: InkWell(
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
                    PriorityIndicator(priority: todo.priority),
                    // Add actions (like edit, delete) here if needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
