import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utilities/extentions/date_ex.dart';

import '../../../core/utilities/app_styles.dart';
import '../../../core/utilities/colors_manager.dart';
import '../../../database_Manager/task_model.dart';
import '../home/add_task.dart';
import '../home/taps/taskTap/tasks_tap.dart';

class Edit extends StatefulWidget {
  final TaskDM task;

  Edit({super.key, required this.task});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late DateTime selectedDate;
  late TextEditingController titleController;
  late TextEditingController descController;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<TasksTapState> tasksTapKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.task.date ?? DateTime.now();  // Set initial date
    titleController = TextEditingController(text: widget.task.title);  // Set initial title
    descController = TextEditingController(text: widget.task.description);  // Set initial description
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        leading: IconButton(
          color: ColorsManager.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 90.h,
            color: ColorsManager.blue,
          ),
          Center(
            child: Container(
              width: 350.w,
              height: 700.h,
              decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Edit Task', style: LightStyle.addTask),
                    TextFormField(
                      validator: (input) =>
                      input == null || input.trim().isEmpty
                          ? 'Please enter task title'
                          : null,
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Edit Title',
                        hintStyle: LightStyle.hintStyle,
                      ),
                    ),
                    TextFormField(
                      validator: (input) =>
                      input == null || input.trim().isEmpty
                          ? 'Please enter task description'
                          : null,
                      controller: descController,
                      decoration: InputDecoration(
                        hintText: 'Task Description',
                        hintStyle: LightStyle.hintStyle,
                      ),
                    ),
                    Text('Select date', textAlign: TextAlign.start, style: LightStyle.selectDate),
                    InkWell(
                      child: Text(
                        selectedDate.toFormattedDate,
                        style: LightStyle.hintStyle,
                      ),
                      onTap: () async {
                        await showTaskDate(context);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop();
                          await editTodoFromFirebase(widget.task);
                          tasksTapKey.currentState?.getTodosFromFireStore();
                        }
                      },
                      child: const Text('Update task'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> editTodoFromFirebase(TaskDM task) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(TaskDM.collectionName);
    DocumentReference todo = collection.doc(task.id);
    Map<String, dynamic> updated = {
      'id': task.id,
      'title': titleController.text,
      'description': descController.text,
      'date': Timestamp.fromDate(selectedDate),  // Use selectedDate here
      'isDone': false
    };
    await todo.update(updated);
  }

  Future<void> showTaskDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: selectedDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;  // Update selectedDate
      });
    }
  }
}
