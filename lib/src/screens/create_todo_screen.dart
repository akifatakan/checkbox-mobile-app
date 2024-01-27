import 'package:CheckBox/src/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';

class CreateTodoScreen extends StatelessWidget {
  CreateTodoScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TodoController todoController = Get.find<TodoController>();
  final UserController userController = Get.find<UserController>();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      todoController.userId.value = userController.user.value!.id;
      todoController.createTodo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'New Todo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => todoController.title.value = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note'),
                onSaved: (value) => todoController.note.value = value ?? '',
                maxLines: 3,
              ),
              Obx(() => DropdownButtonFormField<String>(
                    value: todoController.priority.value,
                    decoration: InputDecoration(labelText: 'Priority'),
                    items: <String>['Low', 'Medium', 'High']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) => {
                      todoController.priority.value = value!,
                    },
                  )),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) => todoController.category.value = value ?? '',
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Tags'),
                  onSaved: (value) =>
                      todoController.setTagsFromString(value ?? '')),
              // ... Repeat for other fields like note, priority, etc. ...

              Obx(
                () => ListTile(
                  title: Text(
                      'Due Date: ${DateFormat('yyyy-MM-dd').format(todoController.dueDate.value)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: todoController.dueDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      todoController.dueDate.value = picked;
                    }
                  },
                ),
              ),

              ElevatedButton(
                onPressed: submitForm,
                child: Text('Create Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
