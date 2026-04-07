class AppRouteNames {
  // We use names for internal navigation (context.goNamed)
  static const String landing = 'landing';
  static const String login = 'login';
  static const String signup = 'signup';

  // We use paths for the browser URL or deep linking
  static const String landingPath = '/';
  static const String loginPath = '/login';
  static const String signupPath = '/signup';

  // Add route for after login and redirecting to bookmark empty state
  static const String bookmarkEmptyState = 'bookmarkEmptyState';
  static const String bookmarkEmptyStatePath = '/bookmarks_empty';

  // bottom nav routes
  static const String bookmarksPath = '/bookmarks';
  static const String collectionsPath = '/collections';
  static const String profilePath = '/profile';
  static const String bookmarks = 'bookmarks';
  static const String collections = 'collections';
  static const String profile = 'profile';
}
