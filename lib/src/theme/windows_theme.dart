import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData windowsTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    // Primary color set to orange
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1F1F1F),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Color(0xFF1F1F1F),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty<Color>.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.hovered: Colors.orange.shade800,
          WidgetState.pressed: Colors.orange.shade900,
          WidgetState.any: Colors.orange,
        }),
        foregroundColor: WidgetStateProperty.all(Colors.orange.shade50),
        shape: WidgetStatePropertyAll(ContinuousRectangleBorder()),
        elevation: WidgetStateProperty.all(0), // Flat design
      ),
    ),

    iconTheme: const IconThemeData(
      color: Colors.grey,
      size: 20,
    ),

    textTheme: GoogleFonts.robotoTextTheme(),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange, width: 2.0),
        // Orange focus border
        borderRadius: BorderRadius.circular(4.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),

    // Adding color scheme to ensure orange is used consistently
    colorScheme: ColorScheme.light(
      primary: Colors.orange.shade400,
      secondary: Colors.orange.shade700,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: const Color(0xFF1F1F1F),
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      selectedLabelTextStyle: const TextStyle(
        color: Colors.orange,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
  );
}
