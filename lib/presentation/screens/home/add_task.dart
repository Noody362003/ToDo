import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utilities/app_styles.dart';
import 'package:todo/core/utilities/extentions/date_ex.dart';
import 'package:todo/database_Manager/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddTaskBottomSheet(),
            ));
  }
}

class AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Add New Task',
                style: LightStyle.addTask,
              ),
              TextFormField(
                validator: (input) {
                  if(input==null || input.trim().isEmpty){
                    return 'please enter task title';
                  }

                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  hintStyle: LightStyle.hintStyle,
                ),
              ),
              TextFormField(
                validator: (input) {
                  if(input==null || input.trim().isEmpty){
                    return 'please enter task description';
                  }

                },
                controller: descController,
                decoration: InputDecoration(
                  hintText: 'Task Description',
                  hintStyle: LightStyle.hintStyle,
                ),
              ),
              Text(
                'Select date',
                textAlign: TextAlign.start,
                style: LightStyle.selectDate,
              ),
              InkWell(
                child: Text(
                  selectedDate.toFormattedDate,
                  style: LightStyle.hintStyle,
                ),
                onTap: () {
                  showTaskDate(context);
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    addTaskToFireStore();
                  },
                  child: const Text('ADD'))
            ],
          ),
        ),
      ),
    );
  }

  void showTaskDate(context) async {
    selectedDate = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            initialDate: DateTime.now()) ??
        selectedDate;
    setState(() {});
  }

  addTaskToFireStore() {
    if(formKey.currentState?.validate() == false) return;

    CollectionReference collection =
        FirebaseFirestore.instance.collection(TaskDM.collectionName);
    DocumentReference document = collection.doc();
    TaskDM todo = TaskDM(
        id: document.id,
        title: titleController.text,
        description: descController.text,
        date: selectedDate,
        isDone: false);
    document
        .set(todo.toFirebase())
        .then((value) => {})
        .onError((error, stackTrace) => {})
        .timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        if(context.mounted){
          Navigator.pop(context);
        }
        throw '';
      },
    );
  }
}
