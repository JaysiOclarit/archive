import 'package:go_router/go_router.dart';
import 'package:archive/core/router/route_names.dart'; // Import your names
import 'package:archive/features/auth/presentation/pages/archive_landing_screen.dart';
import 'package:archive/features/auth/presentation/pages/login_screen.dart';
import 'package:archive/features/auth/presentation/pages/signup_screen.dart';

final goRouter = GoRouter(
  initialLocation: AppRouteNames.landingPath,
  routes: [
    GoRoute(
      path: AppRouteNames.landingPath,
      name: AppRouteNames.landing,
      builder: (context, state) => const ArchiveLandingScreen(),
    ),
    GoRoute(
      path: AppRouteNames.loginPath,
      name: AppRouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRouteNames.signupPath,
      name: AppRouteNames.signup,
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);
