import 'package:archive/presentation/screens/archive_landing_screen.dart';
import 'package:archive/presentation/screens/login_screen.dart';
import 'package:archive/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/', // Where the app starts
  routes: [
    // 1. The Welcome/Landing Screen
    GoRoute(
      path: '/',
      builder: (context, state) => const ArchiveLandingScreen(),
    ),
    // 2. The Login Screen
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
  ],
);
