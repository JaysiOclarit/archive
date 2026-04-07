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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // STRICT COMPLIANCE: Exhaustive switching on sealed class
        switch (state) {
          case AuthError(:final message):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          case AuthAuthenticated():
            context.goNamed(AppRouteNames.landing);
          case AuthPasswordResetSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password reset email sent!")),
            );
          case AuthInitial():
          case AuthLoading():
          case AuthUnauthenticated():
            break; // Do nothing for these states in the listener
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
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
                  const LabelText("Welcome Back", size: LabelSize.large),
                  const SizedBox(height: 10),
                  const EditorialText(
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
                        ),
                        height: 1.6,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Call reset password logic
                        context.read<AuthCubit>().resetUserPassword(
                          _emailController.text,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 10, top: 15),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(
                            (0.6 * 255).round(),
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                                context.read<AuthCubit>().logIn(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const OrDivider(),
                  const SizedBox(height: 30),
                  TactileButton(
                    text: "CONTINUE WITH GOOGLE",
                    onPressed: () {},
                    isPrimary: false,
                    icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelText('New to the Archive?'),
                      TextButton(
                        onPressed: () => context.goNamed(AppRouteNames.signup),
                        child: const Text(
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
