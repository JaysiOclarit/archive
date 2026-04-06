import 'package:get_it/get_it.dart';
// Auth
import 'package:archive/features/auth/data/datasources/auth_data_provider.dart';
import 'package:archive/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:archive/features/auth/domain/usecases/login_user.dart';
import 'package:archive/features/auth/domain/usecases/register_user.dart';
import 'package:archive/features/auth/domain/usecases/logout_user.dart';
import 'package:archive/features/auth/domain/usecases/reset_password.dart';
import 'package:archive/features/auth/domain/usecases/get_user_profile.dart';
import 'package:archive/features/auth/domain/usecases/update_profile.dart';
import 'package:archive/features/auth/domain/usecases/get_current_user_id.dart';
import 'package:archive/features/auth/presentation/bloc/auth_cubit.dart';

// Collection
import 'package:archive/features/collection/data/datasources/collection_data_provider.dart';
import 'package:archive/features/collection/data/repositories/collection_repository_impl.dart';
import 'package:archive/features/collection/domain/repositories/collection_repository.dart';
import 'package:archive/features/collection/domain/usecases/get_all_collections.dart';
import 'package:archive/features/collection/domain/usecases/save_collection.dart';
import 'package:archive/features/collection/domain/usecases/delete_collection.dart';
import 'package:archive/features/collection/presentation/bloc/collection_cubit.dart';

// Bookmark
import 'package:archive/features/bookmark/data/datasources/bookmark_data_provider.dart';
import 'package:archive/features/bookmark/data/repositories/bookmark_repository_impl.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:archive/features/bookmark/domain/usecases/get_all_bookmarks.dart';
import 'package:archive/features/bookmark/domain/usecases/get_bookmarks_by_folder_id.dart';
import 'package:archive/features/bookmark/domain/usecases/save_bookmark.dart';
import 'package:archive/features/bookmark/domain/usecases/delete_bookmark.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // ----------------------------------
  // Data Providers
  // ----------------------------------
  getIt.registerLazySingleton<IAuthDataProvider>(() => FirebaseAuthProvider());
  getIt.registerLazySingleton<ICollectionDataProvider>(
    () => FirebaseCollectionProvider(),
  );
  getIt.registerLazySingleton<IBookmarkDataProvider>(
    () => FirebaseBookmarkProvider(),
  );

  // ----------------------------------
  // Repositories
  // ----------------------------------
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authProvider: getIt<IAuthDataProvider>()),
  );
  getIt.registerLazySingleton<CollectionRepository>(
    () => CollectionRepositoryImpl(
      dataProvider: getIt<ICollectionDataProvider>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<BookmarkRepository>(
    () => BookmarkRepositoryImpl(
      dataProvider: getIt<IBookmarkDataProvider>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );

  // ----------------------------------
  // UseCases : Auth
  // ----------------------------------
  getIt.registerLazySingleton<LoginUser>(
    () => LoginUser(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUser>(
    () => LogoutUser(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPassword>(
    () => ResetPassword(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetUserProfile>(
    () => GetUserProfile(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<UpdateProfile>(
    () => UpdateProfile(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentUserId>(
    () => GetCurrentUserId(repository: getIt<AuthRepository>()),
  );

  // ----------------------------------
  // UseCases : Collection
  // ----------------------------------
  getIt.registerLazySingleton<GetAllCollections>(
    () => GetAllCollections(repository: getIt<CollectionRepository>()),
  );
  getIt.registerLazySingleton<SaveCollection>(
    () => SaveCollection(repository: getIt<CollectionRepository>()),
  );
  getIt.registerLazySingleton<DeleteCollection>(
    () => DeleteCollection(repository: getIt<CollectionRepository>()),
  );

  // ----------------------------------
  // UseCases : Bookmark
  // ----------------------------------
  getIt.registerLazySingleton<GetAllBookmarks>(
    () => GetAllBookmarks(repository: getIt<BookmarkRepository>()),
  );
  getIt.registerLazySingleton<GetBookmarksByFolderId>(
    () => GetBookmarksByFolderId(repository: getIt<BookmarkRepository>()),
  );
  getIt.registerLazySingleton<SaveBookmark>(
    () => SaveBookmark(repository: getIt<BookmarkRepository>()),
  );
  getIt.registerLazySingleton<DeleteBookmark>(
    () => DeleteBookmark(repository: getIt<BookmarkRepository>()),
  );

  // ----------------------------------
  // Presentation (Cubits/BLoCs)
  // ----------------------------------
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      registerUser: getIt<RegisterUser>(),
      loginUser: getIt<LoginUser>(),
      logoutUser: getIt<LogoutUser>(),
      resetPassword: getIt<ResetPassword>(),
      getUserProfile: getIt<GetUserProfile>(),
      updateProfile: getIt<UpdateProfile>(),
      getCurrentUserId: getIt<GetCurrentUserId>(),
    ),
  );
  getIt.registerFactory<CollectionCubit>(
    () => CollectionCubit(
      getAllCollections: getIt<GetAllCollections>(),
      saveCollection: getIt<SaveCollection>(),
      deleteCollection: getIt<DeleteCollection>(),
    ),
  );
  getIt.registerFactory<BookmarkCubit>(
    () => BookmarkCubit(
      getAllBookmarks: getIt<GetAllBookmarks>(),
      getBookmarksByFolderId: getIt<GetBookmarksByFolderId>(),
      saveBookmark: getIt<SaveBookmark>(),
      deleteBookmark: getIt<DeleteBookmark>(),
    ),
  );
}
