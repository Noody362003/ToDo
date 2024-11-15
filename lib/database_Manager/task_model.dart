import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDM {
  static const collectionName='todo';
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  TaskDM({required this.id,required this.title,required this.description,required this.date,this.isDone=false});
  TaskDM.fromFirestore(Map<String,dynamic> task): this(
    id: task['id'],
    title: task['title'],
    description: task['description'],
      date: (task['date'] != null)
          ? (task['date'] as Timestamp).toDate()
          : DateTime.now(),
    isDone: task['isDone']
  );
  Map<String,dynamic> toFirebase() =>{
    'id':id,
    'title': title,
    'description': description,
    'date':date,
    'isDone': isDone
  };



}