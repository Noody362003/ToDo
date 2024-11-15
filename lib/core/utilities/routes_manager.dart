import 'package:flutter/material.dart';
import 'package:todo/database_Manager/task_model.dart';
import 'package:todo/presentation/screens/Auth/login.dart';
import 'package:todo/presentation/screens/Auth/register.dart';
import 'package:todo/presentation/screens/edit/edit.dart';

import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/splash/splash.dart';

class RoutesManager {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String editTask = '/edit';
  static const String register = '/register';
  static const String login = '/login';



  static Route? router(RouteSettings settings)
  {
    switch(settings.name){
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case register:
        return MaterialPageRoute(builder: (context) => Register());
      case login:
        return MaterialPageRoute(builder: (context) => Login());
      case editTask:
        final task = settings.arguments as TaskDM;
        return MaterialPageRoute(builder: (context) => Edit(task: task,));
    }

  }
}