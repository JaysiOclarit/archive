import 'package:flutter/material.dart';

// 1. Define strict sizes so developers can't guess random font sizes
enum EditorialSize { large, medium, small }

class EditorialText extends StatelessWidget {
  final String text;
  final EditorialSize size;
  final Color?
  colorOverride; // Optional: In case we need it on a dark background

  const EditorialText(
    this.text, {
    super.key,
    this.size = EditorialSize.large, // Defaults to the massive headline
    this.colorOverride,
  });

  @override
  Widget build(BuildContext context) {
    // 2. Grab the typography from your "Tactile Archive" theme
    final textTheme = Theme.of(context).textTheme;

    // 3. Map our simple enum to the exact Material 3 tokens
    TextStyle? getStyle() {
      switch (size) {
        case EditorialSize.large:
          return textTheme.displayLarge; // 57px Newsreader
        case EditorialSize.medium:
          return textTheme.headlineMedium; // 28px Newsreader
        case EditorialSize.small:
          return textTheme.titleMedium; // 16px Newsreader
      }
    }

    // 4. Apply the style, keeping the "asymmetric/editorial" feel in mind
    return Text(
      text,
      style: getStyle()?.copyWith(
        color: colorOverride,
        height:
            1.1, // Tightens the line-height for a more "printed magazine" look
      ),
    );
  }
}
