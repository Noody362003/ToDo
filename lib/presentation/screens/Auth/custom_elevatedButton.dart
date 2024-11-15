import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utilities/colors_manager.dart';
typedef Press = void Function();
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onPress,required this.label});
  Press onPress;
  String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)
        )
      ),
        onPressed: onPress,
        child: Text(label,style: TextStyle(color: ColorsManager.white),));
  }
}
