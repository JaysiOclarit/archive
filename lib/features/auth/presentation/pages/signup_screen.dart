import 'package:archive/core/widgets/editorial_text.dart';
import 'package:archive/core/widgets/label_text.dart';
import 'package:archive/core/widgets/or_divider.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/tactile_input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      // The global Warm Paper background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

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

                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: EditorialText(
                    "Begin your collection.",
                    size: EditorialSize.large,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    "Create an account to start curating your personal literary sanctuary",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(
                        0.8,
                      ), // Slightly muted charcoal
                      height:
                          1.6, // Taller line-height makes paragraphs feel more "editorial"
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TactileInputField(label: "Name", placeholder: "Jonathan Doe"),
                const SizedBox(height: 10),
                TactileInputField(
                  label: "Email Address",
                  placeholder: "curator@gmail.com",
                ),
                const SizedBox(height: 10),
                TactileInputField(
                  label: "Password",
                  placeholder: "Enter your password here",
                  isPassword: true,
                ),

                const SizedBox(height: 35),
                TactileButton(text: "Create Account", onPressed: () {}),
                const SizedBox(height: 30),
                OrDivider(),
                const SizedBox(height: 30),
                TactileButton(
                  text: "CONTINUE WITH GOOGLE",
                  onPressed: () {},
                  isPrimary: false,
                  // Pass the fully constructed FaIcon widget!
                  icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelText('Already a member of the archive?'),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
