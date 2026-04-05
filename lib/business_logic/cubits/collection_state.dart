import 'package:equatable/equatable.dart';
import 'package:archive/data/models/collection_model.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

// 1. App just opened, nothing has happened yet
class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

// 2. The Cubit asked the Repository for data, and we are waiting
class CollectionLoading extends CollectionState {
  const CollectionLoading();
}

// 3. SUCCESS! The Repository handed us the safe Dart objects
class CollectionLoaded extends CollectionState {
  final List<Collection> collections;

  const CollectionLoaded(this.collections);

  // We tell Equatable to watch this list. If the list changes, the UI rebuilds.
  @override
  List<Object> get props => [collections];
}

// 4. FAILURE! The internet dropped or the database crashed
class CollectionError extends CollectionState {
  final String message;

  const CollectionError(this.message);

  @override
  List<Object> get props => [message];
}
