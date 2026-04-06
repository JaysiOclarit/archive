import 'package:archive/core/router/route_names.dart';
import 'package:archive/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:archive/features/auth/presentation/bloc/auth_state.dart';
import 'package:archive/core/widgets/editorial_text.dart';
import 'package:archive/core/widgets/label_text.dart';
import 'package:archive/core/widgets/or_divider.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/tactile_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. ADD CONTROLLERS TO CAPTURE TEXT
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks!
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          // Show a beautiful error popup if they typed the wrong password
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthAuthenticated) {
          // SUCCESS! The BLoC says they are logged in.
          // Route them to the main archive and clear the navigation history
          // so they can't hit the "back" button to go to the login screen.
          // Use approute names for navigation consistency and to avoid hardcoding paths all over the app.
          context.goNamed(AppRouteNames.landing);
        }
      },
      child: Scaffold(
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

                  const SizedBox(height: 60),

                  LabelText("Welcome Back", size: LabelSize.large),
                  const SizedBox(height: 10),
                  EditorialText(
                    "Enter the Archive",
                    size: EditorialSize.medium,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      "Return to your curated collection of literature, observations, and timeless bookmarks",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(
                          (0.8 * 255).round(),
                        ), // Slightly muted charcoal
                        height:
                            1.6, // Taller line-height makes paragraphs feel more "editorial"
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TactileInputField(
                    label: "Email Address",
                    placeholder: "curator@gmail.com",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  TactileInputField(
                    label: "Password",
                    placeholder: "Enter your password here",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  // THE NEW FORGOT PASSWORD BUTTON
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            // PRO-TIP: Flutter adds invisible padding to TextButtons by default.
                            // We set these to zero so the text aligns *perfectly* with the left edge of your input box.
                            padding: EdgeInsets.only(right: 10, top: 15),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Forgot password?",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withAlpha(
                                (0.6 * 255).round(),
                              ), // A subtle, editorial gray link
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return TactileButton(
                        text: "LOG IN",
                        onPressed: isLoading
                            ? () {}
                            : () {
                                // When the user taps "Log In", we call the logIn function in our AuthCubit
                                context.read<AuthCubit>().logIn(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              },
                      );
                    },
                  ),
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
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelText('New to the Archive?'),
                      TextButton(
                        onPressed: () {
                          context.goNamed(AppRouteNames.signup);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
