import 'package:CheckBox/src/models/models.dart';
import 'package:CheckBox/src/screens/screens.dart';
import 'package:CheckBox/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search Todo',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TodoSearchDelegate());
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class TodoSearchDelegate extends SearchDelegate<Todo?> {
  final TodoController todoController = Get.find<TodoController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final filteredTodos = todoController.todos.where((todo) {
      return todo.title.toLowerCase().contains(query.toLowerCase()) ||
          todo.note.toLowerCase().contains(query.toLowerCase()) ||
          todo.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = filteredTodos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.note),
            onTap: () {
              Get.to(() => TodoDetailsScreen(todo: todo));
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Filter the TODOs based on the query
    final filteredTodos = todoController.todos.where((todo) {
      return todo.title.toLowerCase().contains(query.toLowerCase()) ||
          todo.note.toLowerCase().contains(query.toLowerCase()) ||
          todo.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: filteredTodos.length,
      itemBuilder: (context, index) {
        final todo = filteredTodos[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.note),
          onTap: () {
            Get.to(() => TodoDetailsScreen(todo: todo));
          },
        );
      },
    );
  }
}
