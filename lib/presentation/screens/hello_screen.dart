import 'package:flutter/material.dart';

class HelloWorldScreen extends StatelessWidget {
  const HelloWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We fetch our Theme tokens here so we can use them below
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      // 1. Set the background to our "Warm Paper" from the theme
      backgroundColor: theme.colorScheme.surface,

      // 2. Body is the main content area
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 3. Our "Curator's Mark" pairing
            Text(
              "WELCOME TO",
              style: textTheme.labelSmall, // Tiny Manrope Sans
            ),
            Text(
              "The Archive",
              style: textTheme.displayLarge, // Large Newsreader Serif
            ),

            const SizedBox(height: 40), // This is "Air" (Whitespace)
            // 4. A Tactile Button
            ElevatedButton(
              onPressed: () {
                print("Button Pressed!");
              },
              child: const Text("Begin Curation"),
            ),
          ],
        ),
      ),
    );
  }
}
