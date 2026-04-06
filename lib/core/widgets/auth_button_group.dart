import 'package:archive/core/router/route_names.dart';
import 'package:archive/core/widgets/tactile_button.dart';
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
            // Always use named routes for navigation to avoid hardcoding paths and to make it easier to refactor later
            context.goNamed(AppRouteNames.signup);
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
            // This is much safer and easier to maintain
            context.goNamed(AppRouteNames.login);
          },
        ),
      ],
    );
  }
}
