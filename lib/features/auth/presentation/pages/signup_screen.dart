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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // STRICT COMPLIANCE: Exhaustive switching
        switch (state) {
          case AuthError(:final message):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          case AuthAuthenticated():
            context.goNamed(AppRouteNames.landing);
          case AuthInitial():
          case AuthLoading():
          case AuthUnauthenticated():
          case AuthPasswordResetSuccess():
            break;
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
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
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
                        color: theme.colorScheme.onSurface.withAlpha(
                          (0.8 * 255).round(),
                        ),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TactileInputField(
                    label: "Name",
                    placeholder: "Jonathan Doe",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),
                  TactileInputField(
                    label: "Email Address",
                    placeholder: "curator@gmail.com",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  TactileInputField(
                    label: "Password",
                    placeholder: "Enter your password here",
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 35),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return TactileButton(
                        text: "CREATE ACCOUNT",
                        onPressed: isLoading
                            ? () {}
                            : () {
                                context.read<AuthCubit>().signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  _nameController.text,
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
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelText('Already a member of the archive?'),
                      TextButton(
                        onPressed: () => context.goNamed(AppRouteNames.login),
                        child: const Text(
                          'Login',
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
