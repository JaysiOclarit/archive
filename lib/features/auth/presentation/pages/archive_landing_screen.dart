import 'package:archive/core/widgets/auth_button_group.dart';
import 'package:archive/core/widgets/hero_text_module.dart';
import 'package:archive/core/widgets/social_proof_bar.dart';
import 'package:flutter/material.dart';

class ArchiveLandingScreen extends StatelessWidget {
  const ArchiveLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.colorScheme.surface, // The global Warm Paper background
      body: SafeArea(
        // Keeps content out of the notch/status bar
        child: SingleChildScrollView(
          // Allows scrolling on smaller phones
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Top margin
                // 1. The Brand Header (We use a Row directly here since it's so simple)
                Row(
                  children: [
                    Icon(Icons.menu_book, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(
                      "The Archive",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // 2. Insert your Modules!
                const HeroTextModule(),

                const SizedBox(height: 48),

                const AuthButtonGroupModule(),

                const SizedBox(height: 48),

                const SocialProofBarModule(),

                const SizedBox(height: 60),

                // 3. The Hero Image (Using a placeholder colored box for now)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    color: theme.colorScheme.surfaceContainer,
                    // TODO: Replace with your actual image asset later:
                    child: Image.asset(
                      'lib/core/assets/images/landing_screen.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 40), // Bottom breathing room
              ],
            ),
          ),
        ),
      ),
    );
  }
}
