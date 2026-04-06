import 'package:equatable/equatable.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => [];
}

final class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

final class CollectionLoading extends CollectionState {
  const CollectionLoading();
}

final class CollectionLoaded extends CollectionState {
  final List<CollectionEntity> collections;

  const CollectionLoaded(this.collections);

  @override
  List<Object?> get props => [collections];
}

final class CollectionError extends CollectionState {
  final String message;

  const CollectionError(this.message);

  @override
  List<Object?> get props => [message];
}
