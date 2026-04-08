import 'package:archive/core/widgets/app_bar.dart';
import 'package:archive/core/widgets/bookmark_card.dart';
import 'package:archive/core/widgets/bookmark_search_bar.dart';
import 'package:archive/core/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bookmark_cubit.dart';
import '../bloc/bookmark_state.dart';
import 'bookmark_empty_state.dart'; // Import the new Search Bar

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkCubit>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ArchiveAppBar(
        title: "The Archive",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0, bottom: 7),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // 1. The Search & Add Bar is NOW ALWAYS VISIBLE!
          const BookmarkSearchBar(),
          const SizedBox(height: 8),
          // 2. The Filter Chips (Wrapped in BlocBuilder!)
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              // Only show the chips if we have successfully loaded data
              if (state is BookmarkLoaded) {
                // Grab the dynamic tags from the Cubit getter we just made
                final dynamicTags = context.read<BookmarkCubit>().availableTags;

                // If there are no tags at all, don't show the horizontal scroll row
                if (dynamicTags.isEmpty) return const SizedBox.shrink();

                // Pass the dynamic tags into the widget!
                return FilterChips(availableTags: dynamicTags);
              }
              // If loading or error, hide the chips
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(
            height: 8,
          ), // A little breathing room before the list starts
          // 2. The Content Area changes based on the Cubit State
          Expanded(
            child: BlocBuilder<BookmarkCubit, BookmarkState>(
              builder: (context, state) {
                if (state is BookmarkLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is BookmarkLoaded && state.bookmarks.isNotEmpty) {
                  return ListView.builder(
                    // Added a bit of top padding so the first card doesn't hit the search bar
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 12.0,
                      bottom: 24.0,
                    ),
                    itemCount: state.bookmarks.length,
                    itemBuilder: (context, index) {
                      return BookmarkCard(bookmark: state.bookmarks[index]);
                    },
                  );
                }

                // If loaded but empty, show your empty state graphic here
                return const BookmarkEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }
}
