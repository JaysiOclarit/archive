import 'package:flutter/material.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';

class CollectionCard extends StatelessWidget {
  final CollectionEntity collection;
  final VoidCallback? onOptionsTapped;
  final VoidCallback? onTap;

  const CollectionCard({
    super.key,
    required this.collection,
    this.onOptionsTapped,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0, // Enforce the "No-Shadow" rule
      color: theme.colorScheme.onPrimary, // White Paper background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1, // Hairline border
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Row: Icon and Options Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular Icon Background
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceDim, // Dim Paper
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconData(
                        collection.iconCodePoint,
                        fontFamily:
                            collection.iconFontFamily ?? 'MaterialIcons',
                      ),
                      color: theme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                  // Options Icon
                  GestureDetector(
                    onTap: onOptionsTapped,
                    child: Icon(
                      Icons.more_horiz,
                      color: theme.colorScheme.onSurface.withAlpha(
                        (0.4 * 255).round(),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(), // Pushes the text to the bottom of the card
              // 2. Bottom Section: Title and Item Count
              Text(
                collection.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "${collection.bookmarks.length} items",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(
                    (0.6 * 255).round(),
                  ),
                  letterSpacing: 0.2, // Slightly tighter tracking for counts
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
