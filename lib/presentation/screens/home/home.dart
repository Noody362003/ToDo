import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/home/add_task.dart';
import 'package:todo/presentation/screens/home/taps/settingTap/settings_tap.dart';
import 'package:todo/presentation/screens/home/taps/taskTap/tasks_tap.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTapState> tasksTapKey=GlobalKey();
  List<Widget> taps=[];

  int index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taps=[
      TasksTap(key: tasksTapKey,),
      SettingsTap()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: taps[index],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(

          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: ''),

          ],
          currentIndex: index,
          onTap: (tapIndex)
          {
            index=tapIndex;
            setState(() {

            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await AddTaskBottomSheet.show(context);
          tasksTapKey.currentState?.getTodosFromFireStore();
          setState(() {

          });
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
