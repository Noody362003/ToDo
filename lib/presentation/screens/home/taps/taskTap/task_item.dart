import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utilities/routes_manager.dart';
import 'package:todo/database_Manager/task_model.dart';
import 'package:todo/presentation/screens/home/taps/taskTap/tasks_tap.dart';

import '../../../../../core/utilities/colors_manager.dart';

class TaskItem extends StatelessWidget {
  TaskDM task;
  GlobalKey<TasksTapState> tasksTapKey=GlobalKey();

  TaskItem({
    super.key,
    required this.task
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        background: Container(
          decoration: BoxDecoration(
            color: ColorsManager.red,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Row(
            children: [
              Icon(Icons.delete, color: ColorsManager.white),
              SizedBox(width: 5),
              Text("delete", style: TextStyle(color: ColorsManager.white)),
            ],
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("edit", style: TextStyle(color: Colors.white)),
              SizedBox(width: 5),
              Icon(Icons.edit, color: Colors.white),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            //delete task
            deleteTodoFromFirebase(task);
            tasksTapKey.currentState?.getTodosFromFireStore();

          } else if (direction == DismissDirection.endToStart) {

            Navigator.pushNamed(context, RoutesManager.editTask,arguments: task);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: const VerticalDivider(
              color: Colors.blue,
              thickness: 3.0,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            title: Text(
              task.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(task.description),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
  void deleteTodoFromFirebase(TaskDM task) async
  {
    CollectionReference collection= FirebaseFirestore.instance.collection(TaskDM.collectionName);
    DocumentReference todo=collection.doc(task.id);
    await todo.delete();
  }


}
