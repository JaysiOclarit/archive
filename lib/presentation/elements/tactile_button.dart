import 'package:flutter/material.dart';

class TactileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // This boolean lets us reuse the exact same code for BOTH buttons
  // on your welcome screen (The green one and the off-white one)
  final bool isPrimary;

  final Widget? icon; // Optional arrow icon

  const TactileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true, // Defaults to the solid green button
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Grab the global theme you set up earlier
    final theme = Theme.of(context);

    // 2. Determine colors based on the isPrimary flag
    final backgroundColor = isPrimary
        ? theme
              .colorScheme
              .primary // Our Moss Green
        : theme.colorScheme.surfaceContainer; // Our layered "Warm Paper" tone

    final textColor = isPrimary
        ? theme
              .colorScheme
              .onPrimary // White text for green background
        : theme.colorScheme.onSurface; // Charcoal text for paper background

    // 3. Build the tactile shape
    return SizedBox(
      width: double.infinity, // Fills the width of whatever container holds it
      height: 56, // A generous, premium touch target size
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0, // CRITICAL: Enforces your "No-Shadow" rule
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ), // Subtle paper-like softening
          ),
          // Ensure it uses your utility font (Manrope)
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        onPressed: onPressed,

        // 4. Layout the Text and optional Icon side-by-side
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Keeps the icon close to the text
          children: [
            // 1. The Icon comes FIRST now!
            if (icon != null) ...[
              icon!,
              const SizedBox(
                width: 8,
              ), // The gap is now on the right of the icon
            ],

            // 2. The Text comes SECOND!
            Text(text),
          ],
        ),
      ),
    );
  }
}
