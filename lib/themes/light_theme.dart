import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Colors.blue,
  ),
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.notoSansArabic(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        surface: Colors.white, secondary: Colors.black , primary: Colors.white ,));
