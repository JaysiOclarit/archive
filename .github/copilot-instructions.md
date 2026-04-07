# Project Context

- Project Name: Archive
- Primary Tech: Flutter, BLoC, Clean Architecture, GoRouter, GetIt.
- Localization: [e.g., English only]
- Theme Strategy: Material 3 with AppRouteNames and AppPallete.

# Flutter Clean Architecture & BLoC Standard Operating Procedures

You are an expert Flutter Developer. You must strictly follow Clean Architecture principles and the BLoC state management pattern.

## 1. Directory Structure & Layers

Always respect the following folder structure:

- `lib/core/`: Global constants, themes, errors, and shared widgets.
- `lib/features/[feature_name]/domain/`: Entities, Repository Interfaces, and UseCases. (No Flutter/Data imports).
- `lib/features/[feature_name]/data/`: Models (DTOs), DataSources, and Repository Implementations.
- `lib/features/[feature_name]/presentation/`: BLoCs, Pages, and Widgets.

## 2. Domain Layer Rules (The Source of Truth)

- **Entities:** Use `Equatable`. Do not include `fromJson` or `toJson` here.
- **Repositories:** Define as `abstract class`.
- **UseCases:** Every UseCase must have a `call` method. Return `Future<Either<Failure, T>>` using the `fpdart` style for error handling.

## 3. Data Layer Rules

- **Models:** Must extend the corresponding Entity. Include `fromJson` and `toJson`.
- **Repositories:** Implement the Domain repository interface. Catch exceptions and return `Left(Failure)`.

## 4. BLoC & State Management

- Use `flutter_bloc` and `equatable`.
- **States:** Always use `sealed class` for the base state.
- **Naming:** Follow `[Feature]Event`, `[Feature]State`, and `[Feature]Bloc`.
- **Logic:** BLoCs must depend on UseCases, never directly on Repositories or DataSources.

## 5. Navigation & Routing

- Use `go_router`.
- Always use `context.goNamed(AppRouteNames.name)` instead of string paths.
- Route names must be pulled from `lib/core/router/route_names.dart`.

## 6. Coding Style

- Use `final` for all class properties.
- Use `const` constructors whenever possible.
- Prefer named parameters for constructors with `required` keywords.
- Always handle all states in `BlocBuilder` or `BlocConsumer` using exhaustive switching.

## 7. Dependency Injection

- Use `get_it`.
- When generating a new class, suggest the registration code for `lib/init_dependencies.dart`.

### MemPalace Integration

- **Context Awareness:** Always check the `archive` wing in MemPalace before proposing new features or refactors.
- **Pattern Matching:** Follow the "Feature-First" architecture patterns (Domain, Data, Presentation) found in the `collection` and `bookmark` wings.
- **Dependency Management:** When adding features, always provide the `GetIt` registration code following the structure in `lib/init_dependencies.dart`.
- **Tool Usage:** Use `mempalace_search` to verify if a shared widget (like `TactileButton`) or a core utility (like `Failure`) already exists before creating a new one.
