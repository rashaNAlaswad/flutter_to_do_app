import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle _textStyle({
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return GoogleFonts.cairo(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

// Headline Bold Style
TextStyle headlineBoldStyle({
  Color color = AppColors.white,
  double fontSize = 28,
}) {
  return _textStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w700,
  );
}

// larg Style
TextStyle largStyle({
  Color color = AppColors.white,
  double fontSize = 18,
}) {
  return _textStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w500,
  );
}

// medium Style
TextStyle mediumStyle({
  Color color = AppColors.white,
  double fontSize = 14,
}) {
  return _textStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w500,
  );
}

// Regular bold Style
TextStyle regularBoldStyle({
  Color color = AppColors.white,
  double fontSize = 12,
}) {
  return _textStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w700,
  );
}

// Regular Style
TextStyle regularStyle({
  Color color = AppColors.white,
  double fontSize = 12,
}) {
  return _textStyle(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w400,
  );
}
