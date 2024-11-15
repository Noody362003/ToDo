import 'package:flutter/material.dart';
import 'package:todo/core/utilities/assets_manager.dart';

import '../../../core/utilities/routes_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 3),
            (){
          Navigator.pushReplacementNamed(context, RoutesManager.register);
        }
    );
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Image(image: AssetImage(AssetsManager.logo),width: 200,height: 200,),
            Image(image: AssetImage(AssetsManager.copyWrite)),

          ],
        ),
      ),
    );
  }
}
