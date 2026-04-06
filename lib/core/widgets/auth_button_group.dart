import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthButtonGroupModule extends StatelessWidget {
  const AuthButtonGroupModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Prevents the column from stretching vertically
      children: [
        // 1. The High-Intent Primary Action
        TactileButton(
          text: "Get Started",
          isPrimary: true, // Uses the Moss Green color
          icon: const Icon(
            Icons.arrow_forward,
            size: 18,
          ), // The subtle directional cue from your design
          onPressed: () {
            // Pure UI Navigation - No BLoC needed here!
            context.go('/signup');
          },
        ),

        // The Intentional Whitespace
        const SizedBox(height: 16),

        // 2. The Low-Intent Secondary Action
        TactileButton(
          text: "Log In",
          isPrimary:
              false, // Automatically switches to the Warm Paper/Charcoal look
          onPressed: () {
            context.go('/login');
          },
        ),
      ],
    );
  }
}
