import 'package:flutter/material.dart';

class GhostVerticalDivider extends StatelessWidget {
  final double height;

  const GhostVerticalDivider({
    super.key,
    this.height = 40.0, // Default height for your stat blocks
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Using a Container instead of the built-in VerticalDivider gives us
    // absolute pixel-perfect control over the thickness and height.
    return Container(
      height: height,
      width: 1.0, // The "whisper" thickness
      color: theme.colorScheme.outlineVariant.withAlpha((0.15 * 255).round()), // The Ghost Rule
    );
  }
}
