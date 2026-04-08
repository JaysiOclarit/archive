import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';
import 'package:archive/features/collection/domain/usecases/get_all_collections.dart';
import 'package:archive/features/collection/domain/usecases/save_collection.dart';
import 'package:archive/features/collection/domain/usecases/delete_collection.dart';
import 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final GetAllCollections _getAllCollections;
  final SaveCollection _saveCollection;
  final DeleteCollection _deleteCollection;

  List<CollectionEntity> _allCollections = [];

  CollectionCubit({
    required GetAllCollections getAllCollections,
    required SaveCollection saveCollection,
    required DeleteCollection deleteCollection,
  }) : _getAllCollections = getAllCollections,
       _saveCollection = saveCollection,
       _deleteCollection = deleteCollection,
       super(const CollectionInitial());

  Future<void> loadCollections() async {
    emit(const CollectionLoading());
    final res = await _getAllCollections.call();

    res.match((failure) => emit(CollectionError(failure.message)), (
      collections,
    ) {
      _allCollections = collections;
      emit(CollectionLoaded(_allCollections));
    });
  }

  void searchCollections(String query) {
    if (query.isEmpty) {
      emit(CollectionLoaded(_allCollections));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filteredList = _allCollections.where((collection) {
      final nameMatches = collection.name.toLowerCase().contains(lowerQuery);
      final notesMatch = collection.notes.toLowerCase().contains(lowerQuery);
      return nameMatches || notesMatch;
    }).toList();

    emit(CollectionLoaded(filteredList));
  }

  Future<void> addCollection(CollectionEntity newCollection) async {
    // Optional: emit(CollectionLoading());

    final result = await _saveCollection.call(newCollection);

    result.fold(
      (failure) {
        // Handle error (e.g., emit an error state or show a snackbar)
        print("Error saving collection: ${failure.message}");
      },
      (_) {
        // SUCCESS: Reload the collections so the UI updates!
        loadCollections();
      },
    );
  }

  Future<void> deleteCollection(String id) async {
    final res = await _deleteCollection.call(id);
    await res.match(
      (failure) async =>
          emit(CollectionError('Failed to delete folder: ${failure.message}')),
      (_) async => await loadCollections(),
    );
  }

  Future<void> updateCollection(CollectionEntity updatedCollection) async {
    final res = await _saveCollection.call(updatedCollection);
    await res.match(
      (failure) async =>
          emit(CollectionError('Failed to update folder: ${failure.message}')),
      (_) async => await loadCollections(),
    );
  }
}
