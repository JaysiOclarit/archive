import 'package:flutter/material.dart';

/// A reusable function to trigger a perfectly styled bottom sheet.
Future<T?> showTactileBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true, // Allows the sheet to move up with the keyboard
    backgroundColor: Theme.of(
      context,
    ).colorScheme.surface, // Uses your Warm Paper
    elevation: 0, // Enforcing the "No-Shadow" rule
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        // Padding ensures the modal doesn't get covered by the keyboard
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. A subtle drag handle at the top
                Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.2 * 255).round()),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 2. The injected custom content
                child,
                const SizedBox(height: 24), // Bottom padding
              ],
            ),
          ),
        ),
      );
    },
  );
}
