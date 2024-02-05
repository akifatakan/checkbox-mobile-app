import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/routes.dart';
import '../commons/commons.dart';
import '../models/todo.dart';

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen({Key? key, required this.todo}) : super(key: key);

  Todo todo;
  final TodoController todoController = Get.find<TodoController>();
  final UserController userController = Get.find<UserController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormChanged = false;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      todo.userId = userController.user.value!.id;
      todoController.editTodo(todo);
      _formKey.currentState!.reset();
      todoController.isEditMode.value = false;
      isFormChanged = false;
      Get.offAllNamed(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> categoryTags = {
      'Work': [
        'Urgent',
        'High Priority',
        'Client Meeting',
        'Research',
        'Presentation',
        'Team Meeting',
        'Remote',
        'Documentation',
        'Coding',
        'Review'
      ],
      'Personal': [
        'Self Care',
        'Family Time',
        'Hobby',
        'Exercise',
        'Meditation',
        'Errands',
        'Calls',
        'Appointments'
      ],
      'Health & Fitness': [
        'Cardio',
        'Strength Training',
        'Meditation',
        'Yoga',
        'Nutrition',
        'Doctor Appointment',
        'Prescription',
        'Hydration'
      ],
      'Education': [
        'Study',
        'Assignment',
        'Exam Prep',
        'Exam',
        'Group Project',
        'Research',
        'Reading',
        'Online Course',
        'Lecture'
      ],
      'Finance': [
        'Bills',
        'Saving',
        'Investment',
        'Taxes',
        'Budgeting',
        'Insurance',
        'Loan Payment'
      ],
      'Household': [
        'Cleaning',
        'Maintenance',
        'Gardening',
        'Cooking',
        'Shopping',
        'Renovation',
        'Decoration'
      ],
      'Social': [
        'Friends',
        'Family',
        'Networking',
        'Party',
        'Call',
        'Visit',
        'Volunteer'
      ],
      'Travel': [
        'Packing',
        'Booking',
        'Itinerary Planning',
        'Sightseeing',
        'Transportation',
        'Accommodation'
      ],
      'Shopping': [
        'Groceries',
        'Clothes',
        'Electronics',
        'Gifts',
        'Essentials',
        'Online Shopping',
        'Market'
      ],
      'Entertainment': [
        'Movies',
        'Reading',
        'Gaming',
        'Crafts',
        'Music',
        'Outdoor Activities'
      ]
      // Add other categories and their tags...
    };
    List<String> initialTags = todo.tags;
    var selectedCategory = todo.category.obs;
    RxList<String> selectedTags = initialTags.obs;
    var selectedDate = todo.dueDate.obs;

    return WillPopScope(
      onWillPop: () async {
        if (isFormChanged || todoController.isEditMode.value) {
          final shouldPop = await _showDiscardChangesDialog(context);
          return shouldPop;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Todo Details',
          actions: [
            IconButton(
              icon: Obx(() => todoController.isEditMode.value
                  ? Icon(Icons.edit_off)
                  : Icon(Icons.edit)),
              onPressed: todoController.toggleEditMode,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Obx(() {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: TextFormField(
                        initialValue: todo.title,
                        readOnly: !todoController.isEditMode.value,
                        decoration: TodoInputDecoration.getDecoration(
                            labelText: 'Title'),
                        onChanged: (value) {
                          isFormChanged = true;
                        },
                        onSaved: (value) => todo.title = value ?? '',
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a title' : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: TextFormField(
                        initialValue: todo.note,
                        readOnly: !todoController.isEditMode.value,
                        decoration: TodoInputDecoration.getDecoration(
                            labelText: 'Note'),
                        onChanged: (value) {
                          isFormChanged = true;
                        },
                        onSaved: (value) => todo.note = value ?? '',
                        maxLines: 3,
                      ),
                    ),
                    Obx(
                      () => todoController.isEditMode.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: DropdownButtonFormField<String>(
                                value: todo.priority,
                                decoration: TodoInputDecoration.getDecoration(
                                    labelText: 'Priority'),
                                items: <String>['Low', 'Medium', 'High']
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  isFormChanged = true;
                                  todo.priority = value!;
                                },
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: TextFormField(
                                readOnly: !todoController.isEditMode.value,
                                initialValue: todo.priority,
                                decoration: TodoInputDecoration.getDecoration(
                                    labelText: 'Priority'),
                                onChanged: (value) {
                                  isFormChanged = true;
                                },
                                onSaved: (value) => todo.priority = value ?? '',
                              ),
                            ),
                    ),
                    Obx(
                      () => todoController.isEditMode.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: DropdownButtonFormField<String>(
                                value: todo.category,
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
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  isFormChanged = true;
                                  selectedCategory.value = value!;
                                  selectedTags.clear();
                                  todo.category = value!;
                                },
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: TextFormField(
                                initialValue: todo.category,
                                readOnly: !todoController.isEditMode.value,
                                decoration: TodoInputDecoration.getDecoration(
                                    labelText: 'Category'),
                                onChanged: (value) {
                                  isFormChanged = true;
                                },
                                onSaved: (value) {
                                  todo.category = value ?? '';
                                  selectedCategory.value = value!;
                                  selectedTags.clear();
                                },
                              ),
                            ),
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Obx(() {
                          var currentTags =
                              categoryTags[selectedCategory.value] ?? [];
                          return Wrap(
                            spacing: 8.0, // Spacing between chips
                            children: currentTags.map((tag) {
                              return ChoiceChip(
                                label: Text(tag),
                                selected: selectedTags.contains(tag),
                                onSelected: !todoController.isEditMode.value
                                    ? null
                                    : (selected) {
                                        if (selected) {
                                          if (!selectedTags.contains(tag))
                                            selectedTags.add(tag);
                                        } else {
                                          selectedTags.remove(tag);
                                        }
                                      },
                              );
                            }).toList(),
                          );
                        })),
                    // ... Repeat for other fields like note, priority, etc. ...

                    Obx(
                      () => todoController.isEditMode.value
                          ? ListTile(
                              title: Text(
                                  'Due Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.value)}'),
                              trailing: Icon(Icons.calendar_today),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate.value,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  selectedDate.value = picked;
                                  isFormChanged = true;
                                }
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Text(
                                'Due Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.value)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                    ),
                    Obx(
                      () => todoController.isEditMode.value
                          ? AuthButton(
                              onPressed: () {
                                todo.tags = selectedTags.value;
                                todo.dueDate = selectedDate.value;
                                submitForm();
                              },
                              label: 'Save',
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: AuthButton(
                                    onPressed: () async {
                                      await todoController.markTodoAsComplete(
                                          userController.user.value!.id,
                                          todo.id!);
                                      Get.offAllNamed(Routes.home);
                                    },
                                    label: 'Complete',
                                    backgroundColor: Colors.green[400],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: AuthButton(
                                    onPressed: () async {
                                      await todoController.deleteTodoOfUserByID(
                                          userController.user.value!.id,
                                          todo.id!);
                                      Get.offAllNamed(Routes.home);
                                    },
                                    label: 'Delete',
                                    backgroundColor: Colors.red[400],
                                    foregroundColor: Colors.white,
                                  ),
                                )
                              ],
                            ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Future<bool> _showDiscardChangesDialog(BuildContext context) async {
  // showDialog returns a Future that completes with the value chosen by the user.
  TodoController todoController = Get.find<TodoController>();
  return (await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Discard changes?'),
          content: Text(
              'You have unsaved changes. Are you sure you want to discard them?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              // Don't discard changes
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoController.isEditMode.value = false;
                Navigator.of(context).pop(true);
              },
              // Discard changes
              child: Text('Discard'),
            ),
          ],
        ),
      )) ??
      false; // Returning false if showDialog returns null (e.g., back button pressed)
}

List<String> setTagsFromString(String tagString) {
  List<String> tagList = tagString.split(',').map((tag) => tag.trim()).toList();
  return tagList;
}
