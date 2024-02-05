import 'package:CheckBox/src/commons/commons.dart';
import 'package:CheckBox/src/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/routes.dart';
import '../widgets/widgets.dart';

class CreateTodoScreen extends StatelessWidget {
  CreateTodoScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TodoController todoController = Get.find<TodoController>();
  final UserController userController = Get.find<UserController>();
  final NavigationController navigationController = Get.find<NavigationController>();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      todoController.userId.value = userController.user.value!.id;
      todoController.createTodo();
      _formKey.currentState!.reset();
      Get.offAllNamed(Routes.home);
      navigationController.setCurrentIndex(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> categoryTags = {
      'Work': ['Urgent', 'High Priority', 'Client Meeting', 'Research', 'Presentation', 'Team Meeting', 'Remote', 'Documentation', 'Coding', 'Review'],
      'Personal': ['Self Care', 'Family Time', 'Hobby', 'Exercise', 'Meditation', 'Errands', 'Calls', 'Appointments'],
      'Health & Fitness': ['Cardio', 'Strength Training', 'Meditation', 'Yoga', 'Nutrition', 'Doctor Appointment', 'Prescription', 'Hydration'],
      'Education': ['Study', 'Assignment', 'Exam Prep', 'Exam', 'Group Project', 'Research', 'Reading', 'Online Course', 'Lecture'],
      'Finance': ['Bills', 'Saving', 'Investment', 'Taxes', 'Budgeting', 'Insurance', 'Loan Payment'],
      'Household': ['Cleaning', 'Maintenance', 'Gardening', 'Cooking', 'Shopping', 'Renovation', 'Decoration'],
      'Social': ['Friends', 'Family', 'Networking', 'Party', 'Call', 'Visit', 'Volunteer'],
      'Travel': ['Packing', 'Booking', 'Itinerary Planning', 'Sightseeing', 'Transportation', 'Accommodation'],
      'Shopping': ['Groceries', 'Clothes', 'Electronics', 'Gifts', 'Essentials', 'Online Shopping', 'Market'],
      'Entertainment': ['Movies', 'Reading', 'Gaming', 'Crafts', 'Music', 'Outdoor Activities']
      // Add other categories and their tags...
    };
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: CustomAppBar(title: 'New Todo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration:
                      TodoInputDecoration.getDecoration(labelText: 'Title'),
                  onSaved: (value) => todoController.title.value = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration:
                      TodoInputDecoration.getDecoration(labelText: 'Note'),
                  onSaved: (value) => todoController.note.value = value ?? '',
                  maxLines: 3,
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: DropdownButtonFormField<String>(
                    value: todoController.priority.value,
                    decoration: TodoInputDecoration.getDecoration(
                        labelText: 'Priority'),
                    items: <String>['Low', 'Medium', 'High']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) => {
                      todoController.priority.value = value!,
                    },
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: DropdownButtonFormField<String>(
                    value: todoController.category.value,
                    decoration: TodoInputDecoration.getDecoration(
                        labelText: 'Category'),
                    items: <String>[
                      'Work',
                      'Personal',
                      'Health & Fitness',
                      'Education',
                      'Finance',
                      'Household',
                      'Social',
                      'Travel',
                      'Shopping',
                      'Entertainment'
                    ]
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      todoController.category.value = value!;
                      todoController.clearSelectedTags();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Obx(() {
                  var currentTags = categoryTags[todoController.category.value] ?? [];
                  return Wrap(
                    spacing: 8.0, // Spacing between chips
                    children: currentTags.map((tag) {
                      return ChoiceChip(
                        label: Text(tag),
                        selected: todoController.tags.contains(tag),
                        onSelected: (bool selected) {
                          todoController.toggleTag(tag);
                        },
                      );
                    }).toList(),
                  );
                }),
              ),
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
                      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      todoController.dueDate.value = picked;
                    }
                  },
                ),
              ),

              AuthButton(
                onPressed: submitForm,
                label: 'Create Todo',
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
