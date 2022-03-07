import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:investing_me_io/utils/colors.dart';

class Themes {
  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.darkGray,
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: AppColors.brightGreen,
      ));

  static final dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkGray,
      backgroundColor: AppColors.softGray,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: AppColors.brightGreen,
      ));
}

TextStyle get heading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.brightGreen));
}

TextStyle get subHeading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
  ));
}

TextStyle get smallSubHeading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ));
}

TextStyle get smallText {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.mutedBrightGreen));
}

TextStyle get smallHeading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.brightGreen));
}

TextStyle get buttonHeading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black));
}

TextStyle get buttonSubHeading {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black54));
}

TextStyle get redWarning {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.brightRed));
}

TextStyle get day {
  return GoogleFonts.notoSansDisplay(
      textStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.brightGreen));
}
