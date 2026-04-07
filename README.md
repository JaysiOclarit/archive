# Archive

A production-ready Flutter application designed to store and organize bookmarks or links with a scalable, feature-first Clean Architecture.

## 📖 What is Archive?

Archive is a professional bookmark management tool that allows users to save, categorize, and organize digital links efficiently. Built with maintainability and scalability in mind, the app implements a **Feature-First Clean Architecture**. This ensures that every conversation, decision, and architectural detail is preserved in a structure that is both searchable and intuitive. The app features full integration for authentication, bookmarking, and collection management, all backed by Firebase.

## 🤔 Why This Architecture?

This project was developed to prevent the common pitfalls of "spaghetti code" and tight coupling found in many growing applications. By enforcing a strict separation of concerns, Archive provides:

* **Testability**: The Domain layer is framework-agnostic (containing no Flutter imports), allowing for 100% unit-testable business logic.
* **Scalability**: The feature-first layout allows for self-contained modules in `lib/features/`, making it easy to add new capabilities without impacting existing global files.
* **Predictability**: State management is explicitly handled via BLoC/Cubit, ensuring the UI reacts only to pre-defined, immutable states.
* **Error Handling**: Data layer exceptions are converted into explicit `Failure` objects, providing a functional approach to error management and preventing unpredictable crashes.

## 🛠 Tech Stack & Tools

* **Framework**: Flutter SDK (`^3.11.4`).
* **State Management**: `flutter_bloc` & `equatable`.
* **Routing**: `go_router` for deep-linking and declarative navigation.
* **Dependency Injection**: `get_it` for a high-performance service locator pattern.
* **Backend / DB**: Firebase (`firebase_auth`, `cloud_firestore`, `firebase_core`).
* **Functional Programming**: `fpdart` for robust error handling and type safety.

## 🏗 Architecture & Folder Structure

The project strictly adheres to a feature-first layout to keep the codebase organized by business logic rather than technical layers.

```text
lib/
├── core/                        # Global shared code (theme, shared widgets, routing)
│   ├── errors/                  # Failure classes and Exceptions
│   ├── router/                  # Centralized go_router configuration
│   └── widgets/                 # Reusable UI components (Tactile buttons, inputs)
├── features/
│   └── <feature>/               # Feature modules: auth, bookmark, collection
│       ├── data/                # Datasources, DTO Models, and Repository Implementations
│       ├── domain/              # Entities, abstract Repositories, and UseCases
│       └── presentation/        # BLoC/Cubits, Pages, and feature-scoped Widgets
├── init_dependencies.dart       # Service locator (GetIt) registrations
└── main.dart                    # App entry point
```

### The Golden Rules of This Codebase
1.  **Pure Domain Layer**: The `domain` layer must never import Flutter or framework-specific packages to remain platform-independent.
2.  **Use Cases**: Presentation logic only communicates with the Domain layer through single-responsibility UseCase classes.
3.  **Explicit DI**: All dependencies are registered in `lib/init_dependencies.dart` and provided via constructor injection.

## ⚙️ Technical Requirements

* **Flutter SDK**: Stable channel (version `^3.11.4`).
* **Dart SDK**: Bundled with the required Flutter version.
* **Platform Targets**: Android SDK, Xcode (iOS), or Desktop targets (Windows, macOS, Linux).

## 🚀 Getting Started

### 1. Clone and Install
```bash
git clone <repo-url>
cd archive
flutter pub get
```

### 2. Firebase Setup
As this app utilizes Firebase for core features, you must configure it for your specific platforms using the FlutterFire CLI or the Firebase console.

### 3. Run the Application
```bash
flutter run
```

## 🧪 Testing

The repository is built for exhaustive testing. You can verify the business logic, state transitions, and UI components by running:
```bash
flutter test
```

## 👨‍💻 Development & Contributing

To maintain high code quality, please follow these project standards:
* **Analyze**: Run `flutter analyze` to catch potential issues before committing.
* **Format**: Use `flutter format .` to ensure consistent code styling.
* **Commits**: Use semantic prefixes such as `feat:`, `fix:`, or `refactor:` to keep the project history readable.
