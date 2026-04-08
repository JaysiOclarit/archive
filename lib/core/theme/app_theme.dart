import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:archive/core/theme/app_palette.dart'; // Import the palette

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppPalette.mossGreen,
        surface: AppPalette.warmPaper,
        onSurface: AppPalette.charcoal,
        primary: AppPalette.mossGreen,
        onPrimary: AppPalette.whitePaper,
        secondary: AppPalette.driedClay,
        surfaceContainerLowest: AppPalette.whitePaper,
        surfaceDim: AppPalette.dimPaper,
        outlineVariant: AppPalette.charcoal.withAlpha((0.15 * 255).round()),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.warmPaper,
        elevation: 0,
        centerTitle: true,
        // 4. Define the global text style for ALL App Bar titles
        titleTextStyle: GoogleFonts.newsreader(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppPalette.charcoal, // Adjust based on your palette
        ),
        // 5. Define the global style for icons (like the back button or actions)
        iconTheme: const IconThemeData(
          color: AppPalette.mossGreen, // Adjust based on your palette
        ),
      ),

      // 2. Typography: The Editorial Conversation
      textTheme: TextTheme(
        // Newsreader for the "Soul" (Headlines/Content)
        displayLarge: GoogleFonts.newsreader(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: AppPalette.charcoal,
        ),
        headlineMedium: GoogleFonts.newsreader(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: AppPalette.charcoal,
        ),
        titleMedium: GoogleFonts.newsreader(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppPalette.charcoal,
        ),

        // Manrope for the "Utility" (Labels/Body/Actions)
        bodyLarge: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppPalette.charcoal,
        ),
        labelSmall: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: AppPalette.mossGreen,
        ),
      ),

      // 3. Component Styles (The "Stationery" Feel)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.mossGreen,
          foregroundColor: AppPalette.whitePaper,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
        ),
      ),

      cardTheme: const CardThemeData(
        color: AppPalette.whitePaper,
        elevation: 0, // "No-Line" & "No-Shadow" rule
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.whitePaper.withAlpha((0.5 * 255).round()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppPalette.charcoal.withAlpha((0.15 * 255).round()),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppPalette.mossGreen, width: 1.5),
        ),
      ),
      dividerTheme: DividerThemeData(color: Colors.transparent, space: 0),
    );
  }
}
