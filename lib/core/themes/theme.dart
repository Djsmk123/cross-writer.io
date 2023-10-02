//theme
import 'package:blogtools/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: CustomColors.greyFont,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: CustomColors.greyFont,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: CustomColors.greyFont,
      ),
      headlineLarge: TextStyle(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
