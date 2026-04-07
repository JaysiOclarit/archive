import 'package:flutter/material.dart';

/// A custom, reusable App Bar for the Archive app.
///
/// Implements [PreferredSizeWidget] so it can be directly assigned
/// to the `appBar` property of a [Scaffold].
class ArchiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  const ArchiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true, // Defaulting to true, but can be overridden
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      // Optional: Add global styling here if you don't want to rely solely on app_theme.dart
      elevation: 0,
      backgroundColor: // use warmpaper from the palette or theme
          Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
    );
  }

  // REQUIRED: This tells the Scaffold exactly how tall this widget needs to be.
  // kToolbarHeight is a standard Flutter constant (usually 56.0).
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
