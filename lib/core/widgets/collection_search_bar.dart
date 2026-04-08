import 'package:archive/core/widgets/collection_form_sheet.dart';
import 'package:archive/core/widgets/tactile_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/collection/presentation/bloc/collection_cubit.dart';

class CollectionSearchBar extends StatelessWidget {
  const CollectionSearchBar({super.key});

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
              height: 56,
              child: TextField(
                style: theme.textTheme.bodyLarge,
                onChanged: (query) {
                  context.read<CollectionCubit>().searchCollections(query);
                },
                decoration: InputDecoration(
                  hintText: "Search collections...",
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
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.onPrimary,
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

          const SizedBox(width: 12),

          // 2. The Square Add Button
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: 45,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: Trigger a showTactileBottomSheet with a CollectionFormSheet
                  // Grab the cubit to pass to the modal
                  final currentCubit = context.read<CollectionCubit>();

                  showTactileBottomSheet(
                    context: context,
                    child: BlocProvider.value(
                      value: currentCubit,
                      child:
                          const CollectionFormSheet(), // Trigger your new sheet!
                    ),
                  );
                  debugPrint("Add Collection Tapped");
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
