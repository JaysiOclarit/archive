import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';
import 'package:archive/features/bookmark/presentation/pages/bookmark_pages.dart';
import 'package:archive/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:archive/features/collection/presentation/pages/collections_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:archive/core/router/route_names.dart';
import 'package:archive/init_dependencies.dart';

// --- AUTH PAGES ---
import 'package:archive/features/auth/presentation/pages/archive_landing_screen.dart';
import 'package:archive/features/auth/presentation/pages/login_screen.dart';
import 'package:archive/features/auth/presentation/pages/signup_screen.dart';

// --- MAIN APP PAGES & SHELL ---
// IMPORTANT: Make sure you actually created this AppShell file previously!
import 'package:archive/core/widgets/app_shell.dart';
// import 'package:archive/features/bookmark/presentation/pages/bookmarks_page.dart';
// import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';

// Create a navigator key for the root to handle overlays/modals properly
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  // Change this to '/bookmarks' temporarily if you want to test the nav bar immediately upon app launch!
  initialLocation: AppRouteNames.landingPath,

  routes: [
    // ==========================================
    // 1. FLAT ROUTES (No Bottom Nav Bar)
    // ==========================================
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

    // ==========================================
    // 2. SHELL ROUTE (WITH Bottom Nav Bar)
    // ==========================================
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // This is where your bottom navigation bar is injected into the screen
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // --- TAB 1: BOOKMARKS ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookmarks', // Adjust to use AppRouteNames if you have it
              name: AppRouteNames.bookmarks,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => getIt<BookmarkCubit>(),
                  child: const BookmarksPage(),
                );
              },
            ),
          ],
        ),

        // --- TAB 2: COLLECTIONS ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collections',
              name: AppRouteNames.collections,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => getIt<CollectionCubit>(),
                  child: const CollectionsPage(),
                );
              },
            ),
          ],
        ),

        // --- TAB 3: PROFILE ---
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: AppRouteNames.profile,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text("Profile Tab"))),
            ),
          ],
        ),
      ],
    ),
  ],
);
