import 'package:flutter/material.dart';

enum LabelSize { large, medium, small }

class LabelText extends StatelessWidget {
  final String text;
  final LabelSize size;
  final Color? colorOverride;

  const LabelText(
    this.text, {
    super.key,
    this.size = LabelSize.medium,
    this.colorOverride,
  }); // Allows us to use it on dark backgrounds if needed

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text.toUpperCase(), // Enforces the "All-Caps" editorial rule
      style: theme.textTheme.labelSmall?.copyWith(
        // If a color is provided, use it. Otherwise, default to Moss Green (primary)
        color: colorOverride ?? theme.colorScheme.primary,
        letterSpacing:
            1.5, // Adds premium "breathing room" between the tiny letters
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
