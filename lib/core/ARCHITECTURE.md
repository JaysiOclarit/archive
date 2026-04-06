# Architecture Guide — Archive

This document is a concise checklist and set of rules for contributors. Follow
these guidelines to keep the codebase consistent, testable, and maintainable.

## Core Principles

- **Single responsibility:** Each file and class has one reason to change.
- **Separation of concerns:** UI, domain, and data layers must not be mixed.
- **Pure domain:** Domain layer must be framework-agnostic (no Flutter imports).
- **Explicit dependencies:** Use constructor injection and register types in one
  place (`lib/init_dependencies.dart`).

## Layer rules (must-follow)

- **Domain** (`lib/features/<feature>/domain`)
  - Contains `entities`, `repositories` (abstract), and `usecases`.
  - No Flutter imports. Use `equatable` for value equality.
  - Usecases expose a `call` method and return `Future<Either<Failure, T>>`.

- **Data** (`lib/features/<feature>/data`)
  - Contains `datasources` (API/local), `models` (DTOs, `fromJson`/`toJson`),
    and `repositories` (implementations of domain interfaces).
  - Catch exceptions and convert to `Failure` objects.

- **Presentation** (`lib/features/<feature>/presentation`)
  - Contains `bloc`/`cubits`, `pages`, and feature `widgets`.
  - BLoCs/Cubits depend on UseCases only (not repositories or datasources).

- **Core** (`lib/core`)
  - App-wide utilities, shared widgets, theme, constants, errors, and router.
  - Keep platform glue and global configuration here.

## Folder & naming conventions

- Feature-first layout: `lib/features/<feature>/{data,domain,presentation}`.
- File names use snake_case; class names use PascalCase.
- Tests mirror the folder layout under `test/`.
- Keep shared UI in `lib/core/widgets` and feature-specific UI in
  `lib/features/<feature>/presentation/widgets`.

## Dependency Injection

- Single registration file: `lib/init_dependencies.dart`.
- Register by feature and by lifetime:
  - `registerLazySingleton` for shared services
  - `registerFactory` for BLoCs/Cubits
- Avoid calling `sl()` directly in deep widgets — prefer constructor injection
  in parent widgets.

## Routing

- Use `go_router` with named routes and a central `route_names.dart`.
- Initialize DI before creating the router if your `redirect` uses auth state.
- Prefer `ShellRoute` for shared UI scaffolds (bottom nav/sidebars).

## Error handling & failures

- Define `Failure` variants in `lib/core/errors/`.
- Data layer converts exceptions to `Failure`.
- Use `Either<Failure, T>` patterns in repositories and usecases.

## BLoC & state rules

- Events/States are immutable and `equatable`.
- BLoCs depend only on UseCases.
- Exhaustive handling: `BlocBuilder`/`BlocConsumer` should account for all
  possible states.

## Models & Mapping

- Domain `entities` are plain Dart objects (no JSON).
- Data `models` extend or map to entities and implement `fromJson`/`toJson`.
- Mapping should be performed in repositories or dedicated mappers.

## Testing

- Unit test: `usecases`, `repositories` (with mocked datasources).
- Bloc test: state transition tests for Cubits/BLoCs.
- Widget test: isolated widget behavior with fake dependencies.
- CI should run: `flutter format --set-exit-if-changed .`, `flutter analyze`,
  `flutter test`.

## Code quality & commits

- Run `flutter analyze` and `dart fix --apply` before committing.
- Commit prefixes: `feat:`, `fix:`, `refactor:`, `chore:`.
- For file moves use `git mv` and include a short mapping in the PR description.

## When rules can be bent

- Prototypes or spike branches may temporarily bend rules — document the
  deviation in the PR and schedule follow-up refactors.

## Quick PR checklist

- [ ] Does this change follow the layer rules?
- [ ] Are new classes single responsibility?
- [ ] Is dependency registration updated (if needed)?
- [ ] Are imports updated and compile clean?
- [ ] Are tests added/updated and passing locally?
- [ ] Is `flutter format` applied?

---

If you'd like, I can also create `test/` templates for new feature tests or add
a pre-commit hook to run formatter and analyzer.
