import 'package:archive/core/widgets/app_bar.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkEmptyState extends StatelessWidget {
  const BookmarkEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const ArchiveAppBar(title: "The Archive"),
      backgroundColor:
          theme.colorScheme.surface, // Using light theme surface color

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                // Put empty_state_bookmark.png in the assets/images folder and reference it here
                children: [
                  const SizedBox(height: 48),
                  // wrap image in a container to give it a background color white, some padding, rounded corners to make it look like a card, and tilt it slightly for a playful effect
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme
                          .colorScheme
                          .surfaceContainerHighest, // Use a variant for contrast
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Transform.rotate(
                      angle: -0.05, // Tilt the image slightly
                      child: Image.asset(
                        'lib/core/assets/images/empty_state_bookmark.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 1. For the "FOUNDATION" label (using Manrope)
                  Text(
                    "FOUNDATION",
                    style: GoogleFonts.manrope(
                      // Use the font method directly here
                      textStyle: theme
                          .textTheme
                          .labelMedium, // Merge with your existing theme
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 2. For the Headline (using Newsreader)
                  Padding(
                    padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Your Archive is a Blank Page",
                      style: GoogleFonts.newsreader(
                        // Make the headline larger and bolder, and make it italic
                        // Text align and indent center
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        textStyle: theme
                            .textTheme
                            .headlineLarge, // Merge with your existing theme
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "The first mark is always the most meaningful. Add a link to begin your collection.",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        textStyle: theme
                            .textTheme
                            .bodyMedium, // Merge with your existing theme
                        color: theme.colorScheme.onSurfaceVariant.withAlpha(
                          (0.8 * 255).round(),
                        ),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  TactileButton(
                    icon: Icon(Icons.add),
                    text: "Add your First Artifact",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
