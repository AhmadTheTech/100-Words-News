import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.blue,
    ),
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.notoSansArabic(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
      secondary: Colors.white,
      primary: Colors.black54,
    ));
