import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utilities/colors_manager.dart';
import 'package:todo/core/utilities/extentions/date_ex.dart';
import 'package:todo/database_Manager/task_model.dart';
import 'package:todo/presentation/screens/home/taps/taskTap/task_item.dart';

class TasksTap extends StatefulWidget {
  TasksTap({super.key});
  @override
  State<TasksTap> createState() => TasksTapState();
}

class TasksTapState extends State<TasksTap> {
  DateTime calenderSelectedDate=DateTime.now();
  List<TaskDM> todoList=[];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 90.h,
              color: ColorsManager.blue,
            ),
            buildCalender(),
          ]
        ),
        Expanded(child: ListView.builder(itemBuilder:(context,index)=> TaskItem(task: todoList[index]),itemCount: todoList.length,))

      ],
    );
  }

  buildCalender(){
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      focusDate: calenderSelectedDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      onDateChange: (selectedDate) {},
      itemBuilder: (context,date,isSelected,onTap){
        return InkWell(
          onTap: (){
            calenderSelectedDate=date;
            getTodosFromFireStore();
          },
          child: Card(
            color: isSelected ? ColorsManager.blue : ColorsManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(date.getDayName),
                Text('${date.day}')
              ],
            ),
          ),
        );
      },
    );
  }

  getTodosFromFireStore()async{
   CollectionReference collection= FirebaseFirestore.instance.collection(TaskDM.collectionName);
   QuerySnapshot collectionSnapshot=await collection.get();
   List<QueryDocumentSnapshot> documentsSnapshot=collectionSnapshot.docs;
   todoList= documentsSnapshot.map((docSnap) {
     Map<String,dynamic> json=docSnap.data() as Map<String,dynamic>;
     TaskDM todo = TaskDM.fromFirestore(json);
     return todo;
   } ).toList();
   todoList =todoList.where((element) => element.date.day==calenderSelectedDate.day
   && element.date.month==calenderSelectedDate.month
   && element.date.year==calenderSelectedDate.year).toList();
  setState(() {

  });
  }
}
