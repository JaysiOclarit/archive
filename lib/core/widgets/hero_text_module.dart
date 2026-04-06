import 'package:archive/core/widgets/editorial_text.dart';
import 'package:archive/core/widgets/label_text.dart';
import 'package:flutter/material.dart';

class HeroTextModule extends StatelessWidget {
  const HeroTextModule({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Left-aligned asymmetry
      children: [
        // 1. The "Chip" (Digital Curator V1.0)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // We use the secondary color (Dried Clay) at a very low opacity
            // to create that subtle tan "paper tag" background
            color: theme.colorScheme.secondary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
              4,
            ), // Slightly sharper corners than buttons
          ),
          child: const LabelText(
            "Digital Curator V1.0",
            size: LabelSize.small,
          ), // LabelText forces uppercase automatically
        ),

        const SizedBox(height: 24), // Deliberate breathing room
        // 2. The Massive Headline
        const EditorialText(
          "Your personal\nlibrary of the\ninternet.", // \n forces the line breaks exactly where you want them
          size: EditorialSize.large,
        ),

        const SizedBox(height: 20),

        // 3. The Body Description
        // We wrap this in Padding to enforce your "Intentional Asymmetry" rule.
        // It prevents the text from stretching all the way to the right edge.
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Text(
            "A tactile sanctuary for the articles, essays, and fragments that define your intellectual landscape. Organized by intent, not algorithms.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(
                0.8,
              ), // Slightly muted charcoal
              height:
                  1.6, // Taller line-height makes paragraphs feel more "editorial"
            ),
          ),
        ),
      ],
    );
  }
}
