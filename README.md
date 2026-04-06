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

<!-- Migration notes removed -->

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

**CI / Linting**

Consider adding `flutter analyze` and `flutter test` to your CI pipeline. Keep
`analysis_options.yaml` tuned to enforce project rules and style.

**Contributing**

1. Fork the repo and create a feature branch.
2. Follow the feature-first layout when adding code.
3. Run `flutter analyze` and `flutter test` before opening a PR.

**License & authors**

Add a `LICENSE` file if you want to make the project public. Add authors or
maintainers in this README or `AUTHORS.md`.
