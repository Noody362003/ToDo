import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utilities/colors_manager.dart';
typedef Validator = String? Function(String?);
class CustomFormField extends StatelessWidget {
  CustomFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text
  });

  String hintText;
  Validator validator;
  TextEditingController controller;
  bool isPassword;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          fillColor: ColorsManager.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: ColorsManager.blue)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: ColorsManager.blue)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: ColorsManager.red)
          ),
          hintText: hintText,
      ),
    );
  }
}
