import 'package:equatable/equatable.dart';
import 'package:archive/features/bookmark/data/models/bookmark_model.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

// 1. App just started, no data yet.
class BookmarkInitial extends BookmarkState {}

// 2. Waiting for the Repository to fetch data (Show a loading spinner in UI)
class BookmarkLoading extends BookmarkState {}

// 3. Data arrived successfully! (Show the list in UI)
class BookmarkLoaded extends BookmarkState {
  final List<Bookmark> bookmarks;

  const BookmarkLoaded(this.bookmarks);

  @override
  List<Object> get props => [bookmarks];
}

// 4. Something went wrong (Show a SnackBar or error text)
class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}
