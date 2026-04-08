import 'package:flutter/material.dart';
import 'package:archive/core/widgets/tactile_button.dart';

class BookmarkActionSheet extends StatelessWidget {
  final String title;
  final String imageUrl;

  const BookmarkActionSheet({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Top Section: Image and Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 64,
                  height: 64,
                  color: Theme.of(context).colorScheme.surfaceDim,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // 2. The 4 Buttons
        TactileButton(
          text: "Edit Bookmark",
          isPrimary: false,
          icon: const Icon(Icons.edit_outlined, size: 20),
          onPressed: () {
            /* Handle Edit */
          },
        ),
        const SizedBox(height: 12),

        TactileButton(
          text: "Move to Collection",
          isPrimary: false,
          icon: const Icon(Icons.folder_outlined, size: 20),
          onPressed: () {
            /* Handle Move */
          },
        ),
        const SizedBox(height: 12),

        TactileButton(
          text: "Share Bookmark",
          isPrimary: false,
          icon: const Icon(Icons.ios_share, size: 20),
          onPressed: () {
            /* Handle Share */
          },
        ),
        const SizedBox(height: 12),

        TactileButton(
          isDestructive: true,
          text: "Delete Bookmark",
          isPrimary: false,
          icon: const Icon(Icons.delete_outline, size: 20),
          onPressed: () {
            /* Handle Delete */
          },
        ),
      ],
    );
  }
}
