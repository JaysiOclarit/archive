import 'package:archive/core/widgets/tactile_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';
import 'bookmark_form_sheet.dart';

class BookmarkSearchBar extends StatelessWidget {
  const BookmarkSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // 1. The Search Field
          Expanded(
            child: SizedBox(
              height: 56, // Matches your TactileButton height perfectly
              child: TextField(
                style: theme.textTheme.bodyLarge,
                onChanged: (query) {
                  // Fire the search event directly to the Cubit as the user types!
                  context.read<BookmarkCubit>().searchBookmarks(query);
                },
                decoration: InputDecoration(
                  hintText: "Search in 'All Bookmarks'",
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(
                      (0.4 * 255).round(),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurface.withAlpha(
                      (0.4 * 255).round(),
                    ),
                  ),
                  // Remove default internal padding to center the text and icon
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),

                  // The "Stationery" Styling rules
                  filled: true,
                  fillColor: theme.colorScheme.onPrimary, // White Paper
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12), // Space between search and add button
          // 2. The Square Add Button
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: 45,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary, // Moss Green
                  foregroundColor: theme.colorScheme.onPrimary, // White Paper
                  elevation: 0, // The "No-Shadow" rule
                  padding: EdgeInsets
                      .zero, // Forces a perfect square around the icon
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Grab the cubit and pass it to the bottom sheet,
                  // exactly like we did for the Action Sheet earlier.
                  final currentCubit = context.read<BookmarkCubit>();

                  showTactileBottomSheet(
                    context: context,
                    child: BlocProvider.value(
                      value: currentCubit,
                      child: const BookmarkFormSheet(),
                    ),
                  );
                },
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
