import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metadata_fetch/metadata_fetch.dart'; // Import the new package

import 'package:archive/core/widgets/tactile_input_field.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/tactile_tag_input.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';

class BookmarkFormSheet extends StatefulWidget {
  final String? folderId;

  const BookmarkFormSheet({super.key, this.folderId});

  @override
  State<BookmarkFormSheet> createState() => _BookmarkFormSheetState();
}

class _BookmarkFormSheetState extends State<BookmarkFormSheet> {
  final TextEditingController _urlController = TextEditingController();
  List<String> _tags = [];

  // New state to disable the button and show a loading indicator
  bool _isFetching = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _saveBookmark() async {
    final url = _urlController.text.trim();

    // Basic URL validation
    if (url.isEmpty || !Uri.parse(url).isAbsolute) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid URL.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() {
      _isFetching = true; // Start the loading state
    });

    try {
      // 1. Fetch the website's metadata
      final data = await MetadataFetch.extract(url);

      // 2. Safely extract data, falling back to defaults if the site lacks metadata
      final fetchedTitle =
          data?.title ?? url; // Fallback to URL if no title exists
      final fetchedDesc = data?.description ?? '';
      final fetchedImage = data?.image ?? '';

      // 3. Create the Entity with the rich data
      final newBookmark = BookmarkEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        url: url,
        title: fetchedTitle,
        description: fetchedDesc,
        imageUrl: fetchedImage,
        createdAt: DateTime.now(),
        folderId: widget.folderId,
        tags: _tags,
      );

      // 4. Save via Cubit and close sheet
      if (mounted) {
        context.read<BookmarkCubit>().addBookmark(newBookmark);
        Navigator.pop(context);
      }
    } catch (e) {
      print("METADATA FETCH ERROR: $e"); // ADD THIS LINE
      // Handle network errors (e.g., website doesn't exist)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to fetch website metadata.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isFetching = false; // Stop the loading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Save Bookmark",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),

        // Input Field (Only URL now)
        TactileInputField(
          label: "URL",
          placeholder: "https://...",
          controller: _urlController,
        ),
        const SizedBox(height: 16),

        // Taxonomy Tags Component
        TactileTagInput(
          label: "TAXONOMY TAGS",
          placeholder: "development, tutorial, ui...",
          initialTags: _tags,
          onTagsChanged: (tags) {
            setState(() {
              _tags = tags;
            });
          },
        ),
        const SizedBox(height: 32),

        // Submit Button (Reacts to the loading state)
        TactileButton(
          // Change text based on state
          text: _isFetching ? "Fetching Data..." : "Save Bookmark",
          isPrimary: true,
          // If fetching, disable the button by passing a null onPressed function
          onPressed: _isFetching ? () {} : _saveBookmark,
        ),
      ],
    );
  }
}
