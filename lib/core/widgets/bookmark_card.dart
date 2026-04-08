import 'package:archive/core/widgets/bookmark_action_sheet.dart';
import 'package:archive/core/widgets/tactile_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';

class BookmarkCard extends StatelessWidget {
  final BookmarkEntity bookmark;

  const BookmarkCard({super.key, required this.bookmark});

  void _showOptions(BuildContext context) {
    // Grab the cubit before opening the modal, just like we did for the form!
    final currentCubit = context.read<BookmarkCubit>();

    showTactileBottomSheet(
      context: context,
      child: BlocProvider.value(
        value: currentCubit,
        child: BookmarkActionSheet(
          title: bookmark.title,
          imageUrl: bookmark.imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Clean up the URL to just show the domain (e.g., "pub.dev")
    final uri = Uri.tryParse(bookmark.url);
    final domain = uri?.host.replaceFirst('www.', '') ?? bookmark.url;

    return Card(
      // Inherits your CardTheme (whitePaper, 0 elevation)
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1, // A subtle hairline border for the editorial look
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Launch the URL in an in-app browser or external browser
          debugPrint("Opening: ${bookmark.url}");
        },
        onLongPress: () => _showOptions(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Section
            AspectRatio(
              aspectRatio: 16 / 9,
              child: bookmark.imageUrl.isNotEmpty
                  ? Image.network(
                      bookmark.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildImagePlaceholder(theme),
                    )
                  : _buildImagePlaceholder(theme),
            ),

            // 2. Text Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Domain and Options Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          domain.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(
                              (0.6 * 255).round(),
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showOptions(context),
                        child: Icon(
                          Icons.more_horiz,
                          color: theme.colorScheme.onSurface.withAlpha(
                            (0.4 * 255).round(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title (Using Newsreader)
                  Text(
                    bookmark.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (bookmark.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      bookmark.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        height: 1.4, // Good line height for readability
                        color: theme.colorScheme.onSurface.withAlpha(
                          (0.7 * 255).round(), // 70% opacity charcoal
                        ),
                      ),
                      maxLines: 3, // Restrict to 3 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Tags (If any exist)
                  if (bookmark.tags.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: bookmark.tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceDim,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "#$tag",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      theme.colorScheme.secondary, // Dried Clay
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A clean, dim placeholder for websites that don't have metadata images
  Widget _buildImagePlaceholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceDim,
      child: Center(
        child: Icon(
          Icons.public,
          size: 32,
          color: theme.colorScheme.onSurface.withAlpha((0.2 * 255).round()),
        ),
      ),
    );
  }
}
