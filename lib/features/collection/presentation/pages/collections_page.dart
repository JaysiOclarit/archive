import 'package:archive/core/widgets/app_bar.dart';
import 'package:archive/core/widgets/collection_card.dart';
import 'package:archive/core/widgets/collection_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_cubit.dart';
import '../bloc/collection_state.dart';
import 'collections_empty_state.dart'; // 1. Import your new empty state

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionCubit>().loadCollections();
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
          const CollectionSearchBar(),
          const SizedBox(height: 8),

          Expanded(
            child: BlocBuilder<CollectionCubit, CollectionState>(
              builder: (context, state) {
                if (state is CollectionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CollectionLoaded && state.collections.isNotEmpty) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 12.0,
                      bottom: 24.0,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: state.collections.length,
                    itemBuilder: (context, index) {
                      final collection = state.collections[index];
                      return CollectionCard(
                        collection: collection,
                        onTap: () {
                          debugPrint("Tapped collection: ${collection.name}");
                        },
                        onOptionsTapped: () {
                          debugPrint("Options tapped for: ${collection.name}");
                        },
                      );
                    },
                  );
                }

                // 2. IF EMPTY, RETURN YOUR BEAUTIFUL NEW WIDGET!
                return const CollectionsEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }
}
