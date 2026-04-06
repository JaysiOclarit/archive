# Archive

Opinionated starter and refactor layout for the Archive Flutter app.

This README documents how the project is organized, how to run it locally,
and the recommended project layout.

**Table of contents**

- Project overview
- Requirements
- Quick start
  -- Project structure (recommended)
  -- Development tips and common commands
- Contributing

**Project overview**

This app is a Flutter application that groups code by feature. The repository
already contains an initial feature-based layout for `auth`, `bookmark`, and
`collection`. Shared UI and utilities live in `lib/core/`.

Use this README to get the app running, to understand where to place new
code, and to follow the recommended file mappings when refactoring legacy
`lib/data` or `lib/presentation` files into feature folders.

This README is written from the perspective of a developer working on the
codebase. It includes concrete instructions, code snippets, and conventions we
use to keep the project maintainable.

If anything in this README is out of date relative to the codebase, open a
small PR to keep docs and code in sync.

**Requirements**

- Flutter SDK (stable channel, recommended recent version)
- Dart (bundled with Flutter)
- Android SDK / Xcode (for device targets you plan to run)

Confirm your environment:

```bash
flutter --version
flutter doctor
```

**Quick start**

Clone, get packages, and run on a device:

```bash
git clone <repo-url>
cd archive
flutter pub get
flutter run
```

To analyze and format code:

```bash
flutter analyze
flutter format .
```

**Project structure (recommended layout)**

High-level layout used by this repository (feature-first):

```
lib/
├── core/                        # Global shared code
│   ├── constants/               # App-wide constants (colors, strings)
│   ├── errors/                  # Failure classes and Exceptions
│   ├── params/                  # Common UseCase parameters
│   ├── util/                    # Extension methods, formatters
│   └── widgets/                 # Reusable UI components (buttons, loaders)
├── features/
│   └── <feature>/               # e.g. auth, bookmark, collection
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/            # BLoC / Cubit classes, states
│           ├── pages/           # Full screen widgets
│           └── widgets/         # Feature-scoped widgets
├── init_dependencies.dart       # Service locator (GetIt) registrations
└── main.dart                    # App entry point
```

Current repository already follows most of this layout. See `lib/features`
and `lib/core` for examples.

Note: this repository contains `firebase_options.dart`; if you use Firebase
features, configure Firebase for each platform (Android, iOS, Web) using the
FlutterFire CLI or the Firebase console. Do not commit secret JSON/keys.

**Dependency injection (service locator)**

We register app-level dependencies in `lib/init_dependencies.dart` and call
the initializer from `main()` before `runApp()`. Use `get_it` for a simple and
explicit service locator. Keep registrations grouped by feature and by scope
(singletons, lazy singletons, factories).

Example (starter) `lib/init_dependencies.dart`:

```dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
	// Core / shared
	// sl.registerLazySingleton<NetworkClient>(() => DioNetworkClient());

	// Feature: Auth
	// sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
	// sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remote: sl()));
	// sl.registerFactory(() => AuthCubit(authRepository: sl()));
}
```

Call it from `lib/main.dart`:

```dart
void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await initDependencies();
	runApp(const MyApp());
}
```

**Service locator and app startup**

Place dependency registration in `lib/init_dependencies.dart` and call it from
`main()` before `runApp(...)`:

```dart
// example
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
	// sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(...));
}
```

Then in `main.dart`:

```dart
void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await initDependencies();
	runApp(MyApp());
}
```

**Development tips & common commands**

- Install packages: `flutter pub get`
- Run analyzer: `flutter analyze`
- Format code: `flutter format .` or `dart format .`
- Run on Android emulator: `flutter run -d emulator-5554` (example device id)
- Run unit/widget tests: `flutter test`

Useful commands (Windows PowerShell):

```powershell
# get packages
flutter pub get

# analyze and fix minor issues
flutter analyze
dart fix --apply

# run the app on the default device
flutter run

# build release for Android
flutter build apk --release

# run tests
flutter test
```

**CI / Linting**

Consider adding `flutter analyze` and `flutter test` to your CI pipeline. Keep
`analysis_options.yaml` tuned to enforce project rules and style.

Suggested CI steps (example):

- Checkout, install Flutter (matching channel), run `flutter pub get`
- `flutter format --set-exit-if-changed .` to enforce formatting
- `flutter analyze`
- `flutter test`

Add caching for Flutter and pub in CI to speed up runs.

**Contributing**

1. Fork the repo and create a feature branch.
2. Follow the feature-first layout when adding code.
3. Run `flutter analyze` and `flutter test` before opening a PR.

When opening a PR, include:

- Short description of the change and rationale
- A concise migration plan if files are moved (list of moved paths)
- A checklist of manual steps if the change affects platform configs

Follow these commit message prefixes to keep history readable:

- `feat:` new feature
- `fix:` bug fix
- `refactor:` code or file moves with no behavior change
- `chore:` tooling, CI, formatting

Example commit message for this refactor:

```
refactor: adopt feature-first layout & update README

Move files into `lib/features/*` and update docs. No functional changes.
```

**License & authors**

Add a `LICENSE` file if you want to make the project public. Add authors or
maintainers in this README or `AUTHORS.md`.

---

Appendix — Folder guidance (detailed)

Put new code according to the feature-first layout. Examples and rationale:

- `lib/core/` — shared code used by multiple features: theming (`app_theme.dart`),
  shared widgets (buttons, loaders), network clients, and app-wide constants.

- `lib/features/<feature>/data/datasources` — API clients, local DB access
  (e.g., Hive/SharedPreferences), and other I/O concerns. Keep raw DTOs and JSON
  parsing logic here.

- `lib/features/<feature>/data/models` — data transfer objects used by data layer
  (DTOs). Map DTOs to domain entities in the repository implementation.

- `lib/features/<feature>/data/repositories` — concrete implementations of
  domain repositories; coordinate datasources and mappers here.

- `lib/features/<feature>/domain/entities` — plain Dart classes describing the
  core business objects. Keep domain-layer classes free of Flutter.

- `lib/features/<feature>/domain/repositories` — abstract interfaces the data
  layer implements. Keep these pure Dart and small.

- `lib/features/<feature>/domain/usecases` — single-responsibility classes that
  orchestrate domain logic (e.g., `GetBookmarks`, `LoginUser`). Prefer small
  return types and clear error handling.

- `lib/features/<feature>/presentation/bloc` — BLoC / Cubit classes, plus
  state classes. Keep UI logic here and avoid direct network or DB calls.

- `lib/features/<feature>/presentation/pages` — full-screen widgets (routes).

- `lib/features/<feature>/presentation/widgets` — smaller, feature-scoped
  UI components used only inside the feature.

Troubleshooting tips

- If imports break after moving files, run your IDE's "Organize Imports" or
  perform a repo-wide search/replace of old package paths to new ones.
- If you see analyzer errors referencing packages, run `flutter pub get` and
  ensure `analysis_options.yaml` isn't overly strict for quick refactors.

Contact / maintainers

If you need help with the migration or want me to apply planned file moves,
reply with which of these you'd like me to do next:

1. Create missing `lib/core/*` folders and sample files
2. Move top-level `lib/presentation` shared UI into `lib/core/widgets`
3. Generate `lib/init_dependencies.dart` and patch `lib/main.dart` to call it

I'll perform the selected actions and run `flutter analyze` to verify.
