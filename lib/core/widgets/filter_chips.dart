import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';

class FilterChips extends StatefulWidget {
  // You can dynamically generate this list from your backend later,
  // but for now, we'll hardcode some standard taxonomy tags based on your mockups.
  final List<String> availableTags;

  const FilterChips({
    super.key,
    this.availableTags = const [
      'flutter',
      'ui',
      'mobile',
      'development',
      'design',
      'architecture',
    ],
  });

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  // 'All' is selected by default
  String _selectedTag = 'All';

  void _onTagSelected(String tag) {
    setState(() {
      _selectedTag = tag;
    });

    // 1. If 'All' is selected, pass an empty string to reset the filter
    // 2. Otherwise, pass the specific tag to the cubit
    final query = tag == 'All' ? '' : tag;
    context.read<BookmarkCubit>().filterByType(query);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Combine 'All' with the rest of the available tags
    final allChips = ['All', ...widget.availableTags];

    return SizedBox(
      height: 40, // Fixed height for the horizontal scroll area
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: allChips.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = allChips[index];
          final isSelected = _selectedTag == tag;

          return GestureDetector(
            onTap: () => _onTagSelected(tag),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // Moss Green if selected, Dim Paper if unselected
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceDim,
                // True pill shape
                borderRadius: BorderRadius.circular(24),
                // Only add a subtle border if it's NOT selected
                border: isSelected
                    ? null
                    : Border.all(color: theme.colorScheme.outlineVariant),
              ),
              alignment: Alignment.center,
              child: Text(
                tag == 'All' ? tag : "#$tag", // Add the hashtag to actual tags
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  // White Paper text if selected, Charcoal if unselected
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
