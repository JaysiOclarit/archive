// lib/features/bookmark/presentation/pages/bookmarks_page.dart
import 'package:archive/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bookmark_cubit.dart';
import '../bloc/bookmark_state.dart';
import 'bookmark_empty_state.dart'; // Import your widget here

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // According to your architecture, use BlocBuilder to handle all states exhaustively
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BookmarkLoaded && state.bookmarks.isNotEmpty) {
          // If there are bookmarks, show the list
          return Scaffold(
            appBar: const ArchiveAppBar(title: "The Archive"),
            body: ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) =>
                  Text(state.bookmarks[index].title),
            ),
          );
        }

        // If the state is loaded but empty (or initial state), show your empty state screen!
        return const BookmarkEmptyState();
      },
    );
  }
}
