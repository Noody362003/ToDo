import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:todo/core/utilities/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LightStyle{
  static TextStyle appBarStyle=GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );
  static TextStyle sittingsText=GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ColorsManager.black,
  );
  static TextStyle addTask=GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ColorsManager.addTaskColor,
  );

  static TextStyle selectedItem=GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorsManager.blue,
  );
  static TextStyle selectDate=GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: ColorsManager.addTaskColor,
  );
  static TextStyle hintStyle=GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: ColorsManager.hintColor,
  );


}