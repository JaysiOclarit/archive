import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1. The "Tactile" Palette
  static const Color _warmPaper = Color(0xFFFBF9F4);
  static const Color _mossGreen = Color(0xFF546253);
  static const Color _driedClay = Color(0xFF6A5D50);
  static const Color _charcoal = Color(0xFF31332C);
  static const Color _whitePaper = Color(0xFFFFFFFF);
  static const Color _dimPaper = Color(0xFFD9DBCF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _mossGreen,
        surface: _warmPaper,
        onSurface: _charcoal,
        primary: _mossGreen,
        onPrimary: _whitePaper,
        secondary: _driedClay,
        surfaceContainerLowest: _whitePaper,
        surfaceDim: _dimPaper,
        outlineVariant: _charcoal.withOpacity(0.15),
      ),

      // 2. Typography: The Editorial Conversation
      textTheme: TextTheme(
        // Newsreader for the "Soul" (Headlines/Content)
        displayLarge: GoogleFonts.newsreader(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: _charcoal,
        ),
        headlineMedium: GoogleFonts.newsreader(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: _charcoal,
        ),
        titleMedium: GoogleFonts.newsreader(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _charcoal,
        ),

        // Manrope for the "Utility" (Labels/Body/Actions)
        bodyLarge: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: _charcoal,
        ),
        labelSmall: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: _mossGreen,
        ),
      ),

      // 3. Component Styles (The "Stationery" Feel)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _mossGreen,
          foregroundColor: _whitePaper,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
        ),
      ),

      cardTheme: const CardThemeData(
        color: _whitePaper,
        elevation: 0, // "No-Line" & "No-Shadow" rule
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _whitePaper.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _charcoal.withOpacity(0.15)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: _mossGreen, width: 1.5),
        ),
      ),
    );
  }
}
