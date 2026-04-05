import 'package:archive/presentation/elements/editorial_text.dart';
import 'package:archive/presentation/elements/label_text.dart';
import 'package:flutter/material.dart';

class StatBlock extends StatelessWidget {
  final String value; // e.g., "4.8k+"
  final String label; // e.g., "CURATORS"

  const StatBlock({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Keeps the text left-aligned
      mainAxisSize: MainAxisSize
          .min, // Tells the column to only be as tall as it needs to be
      children: [
        // 1. The Large Serif Number
        EditorialText(
          value,
          size: EditorialSize.medium, // Using the medium size from your enum
        ),

        // 2. The Internal Spacing
        const SizedBox(
          height: 4,
        ), // A tiny breath of space between the number and label
        // 3. The Tiny Sans-Serif Label
        LabelText(label),
      ],
    );
  }
}
