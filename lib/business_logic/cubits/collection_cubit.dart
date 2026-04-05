import 'package:archive/data/models/collection_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/data/repositories/collection_repository.dart';
import 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  // The Cubit holds a reference to the Repository so it can ask for data
  final CollectionRepository _repository;

  // --- ADD THIS: The Master List ---
  // This holds the real data so we don't lose it when we search
  List<Collection> _allCollections = [];

  // We inject the repository and set the very first state to Initial
  CollectionCubit({required CollectionRepository repository})
    : _repository = repository,
      super(const CollectionInitial());

  /// This function is called by the UI when the screen opens
  Future<void> loadCollections() async {
    try {
      // 1. Tell the UI to show a spinning loading circle
      emit(CollectionLoading());

      // Fetch from Firebase and save to our Master List
      _allCollections = await _repository.getAllCollections();

      // Tell the UI to show the Master List
      emit(CollectionLoaded(_allCollections));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  // --- ADD THIS SEARCH FUNCTION ---
  /// Filters the loaded collections in memory (Zero Firebase cost!)
  void searchCollections(String query) {
    // If the search bar is empty, just show everything again
    if (query.isEmpty) {
      emit(CollectionLoaded(_allCollections));
      return;
    }

    // Convert query to lowercase to make search case-insensitive
    final lowerQuery = query.toLowerCase();

    // Filter the master list
    final filteredList = _allCollections.where((collection) {
      final nameMatches = collection.name.toLowerCase().contains(lowerQuery);
      final notesMatch = collection.notes.toLowerCase().contains(lowerQuery);

      return nameMatches || notesMatch;
    }).toList();

    // Emit the newly filtered list! The UI will instantly update.
    emit(CollectionLoaded(filteredList));
  }

  /// This function is called by the UI when a user taps "Save Collection"
  Future<void> addCollection(Collection newCollection) async {
    try {
      // We don't emit loading here if we want to add it silently in the background,
      // but you can if you want a full-screen spinner.

      // 1. Tell the Data Layer to save the new item to the database
      await _repository.saveCollection(newCollection);

      // 2. Refresh the list so the UI shows the newly added item
      await loadCollections();
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  /// Deletes a collection and refreshes the list
  Future<void> deleteCollection(String id) async {
    try {
      // We don't necessarily need a loading spinner for deletes,
      // but we do need to catch errors.
      await _repository.deleteCollection(id);

      // Once deleted from the database, fetch the fresh list!
      await loadCollections();
    } catch (e) {
      emit(CollectionError('Failed to delete folder: $e'));
    }
  }

  /// Updates an existing collection (e.g., renaming a folder)
  Future<void> updateCollection(Collection updatedCollection) async {
    try {
      // Because our Data Provider uses SetOptions(merge: true),
      // saveCollection handles both new inserts AND updates!
      await _repository.saveCollection(updatedCollection);

      // Refresh the screen with the newly updated data
      await loadCollections();
    } catch (e) {
      emit(CollectionError('Failed to update folder: $e'));
    }
  }
}
