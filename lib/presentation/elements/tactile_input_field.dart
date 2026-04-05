import 'package:archive/presentation/elements/label_text.dart';
import 'package:flutter/material.dart';

// We get to reuse the Element we already built!

class TactileInputField extends StatelessWidget {
  final String label; // The text sitting on top (e.g., "EMAIL ADDRESS")
  final String
  placeholder; // The text inside the box (e.g., "name@example.com")
  final bool isPassword; // Tells the field to hide the text with dots
  final TextEditingController? controller; // How we grab the typed text later

  const TactileInputField({
    super.key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align everything to the left
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. The Label on top
        // We reuse your LabelText element so it automatically gets the
        // tiny, all-caps, Manrope font with wide letter spacing.
        LabelText(label),

        const SizedBox(height: 8), // A small gap between the label and the box
        // 2. The Input Box
        TextFormField(
          controller: controller,
          obscureText: isPassword, // Hides text if it's a password field
          style: theme
              .textTheme
              .bodyLarge, // Uses your Manrope body font for typed text
          // 3. The Styling (Relying on your global Theme)
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),

            // 1. Tell Flutter to paint a background color
            filled: true,

            // 2. Set the background to your specific Theme token
            fillColor: theme.colorScheme.onPrimary,

            // Optional: Add a little internal padding so the text doesn't touch the edges
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
