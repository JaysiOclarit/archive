import 'package:flutter/material.dart';

// We get to reuse your typography element!
import 'label_text.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Applying your strict "Ghost Border" rule to the horizontal lines
    final dividerColor = theme.colorScheme.outlineVariant.withOpacity(0.15);

    return Row(
      children: [
        // 1. The Left Line
        // 'Expanded' tells the line to stretch exactly as far as it can
        // without pushing the "OR" text off the screen.
        Expanded(child: Divider(color: dividerColor, thickness: 1)),

        // 2. The Middle Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LabelText(
            "OR", // Reusing your tiny, all-caps, Manrope font element
            colorOverride: theme.colorScheme.onSurface.withOpacity(
              0.5,
            ), // Faded charcoal
          ),
        ),

        // 3. The Right Line
        Expanded(child: Divider(color: dividerColor, thickness: 1)),
      ],
    );
  }
}
