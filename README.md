# Archive

A production-ready Flutter application showcasing a scalable, feature-first Clean Architecture. 

## 📖 What is Archive?

Archive is a robust Flutter application designed with maintainability, scalability, and testability as its core pillars. Instead of standard "layer-first" grouping (where all UI is in one folder, and all data in another), this project implements a **Feature-First Clean Architecture**. 

Currently, the app implements features such as Authentication, Bookmarks, and Collections, all backed by Firebase and bound together using strict domain-driven design principles.

## 🤔 Why This Architecture?

As applications grow, spaghetti code and tight coupling between UI and business logic become major bottlenecks. I designed this architecture to solve those exact problems. By enforcing a strict separation of concerns, this codebase ensures:

* **Testability:** Business logic (Domain) is completely isolated from the UI and external frameworks, making it 100% unit-testable.
* **Scalability:** Adding a new feature doesn't mean modifying 10 different global files. You simply drop a new feature folder into `lib/features/` and register its dependencies.
* **Predictability:** State management is explicitly handled by BLoC/Cubit, meaning UI only ever reacts to strict, pre-defined states.
* **Error Handling:** Using functional programming concepts (`fpdart`), errors are caught at the Data layer and returned as explicit `Failure` types, eliminating unpredictable app crashes.

## 🛠 Tech Stack & Tools

* **Framework:** Flutter SDK (`^3.11.4`)
* **State Management:** `flutter_bloc` & `equatable`
* **Routing:** `go_router` (Named routes with ShellRoute for shared scaffolds)
* **Dependency Injection:** `get_it` (Service Locator pattern)
* **Backend / DB:** Firebase (`firebase_auth`, `cloud_firestore`)
* **Functional Programming:** `fpdart` (For `Either<Failure, Success>` error handling)
* **Styling:** `google_fonts`, `font_awesome_flutter`, `cupertino_icons`

## 🏗 Architecture & Folder Structure

The project strictly follows a **Feature-First** layout. Each feature is a self-contained module containing its own Data, Domain, and Presentation layers.

```text
lib/
├── core/                        # Global app utilities, themes, routing, and shared UI
│   ├── errors/                  # Global Failure classes
│   ├── router/                  # go_router configuration
│   ├── theme/                   # AppPalette, AppTheme
│   └── widgets/                 # Reusable UI (Tactile buttons, inputs, etc.)
├── features/
│   ├── auth/                    # Feature: Authentication
│   ├── bookmark/                # Feature: Bookmarks
│   └── collection/              # Feature: Collections
│       ├── data/                # APIs, local DBs, DTOs (Models), Repository Impls
│       ├── domain/              # Entities, abstract Repositories, UseCases (Framework agnostic)
│       └── presentation/        # BLoC/Cubits, Pages, and local Widgets
├── init_dependencies.dart       # Centralized GetIt dependency registration
└── main.dart                    # App entry point
```

### The Golden Rules of This Codebase
1.  **Pure Domain Layer:** The `domain` folder must **never** import `flutter/material.dart` or any UI/Data framework. It is pure Dart.
2.  **Use Cases:** UI (Cubits/BLoCs) only communicates with the Domain layer through explicitly defined `UseCases`.
3.  **Explicit DI:** All dependencies are injected via constructor injection and registered in `init_dependencies.dart`.

## ⚙️ Technical Requirements

To run and build this project, you will need:
* **Flutter SDK:** Version `3.11.4` or higher.
* **Dart SDK:** Version `3.1.0` or higher.
* **IDE:** VS Code or Android Studio with Flutter/Dart extensions installed.
* **Tooling:** CocoaPods (for iOS build), Android SDK (for Android build).

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone <repository-url>
cd archive
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration
This project relies on Firebase for Authentication and Firestore. You must generate the `firebase_options.dart` file using the FlutterFire CLI before running the app.
```bash
# Install FlutterFire CLI if you haven't already
dart pub global activate flutterfire_cli

# Configure your project (select your Firebase project)
flutterfire configure
```
*(Note: Never commit your actual `google-services.json` or `GoogleService-Info.plist` to public version control).*

### 4. Run the application
```bash
flutter run
```

## 🧪 Testing

Testing is a first-class citizen in this repository. The testing structure mirrors the `lib/` folder structure.
* **Unit Tests:** For UseCases, Repositories, and pure logic.
* **BLoC Tests:** To verify state transitions based on given events.
* **Widget Tests:** To ensure UI components render correctly with mocked dependencies.

Run the test suite locally using:
```bash
flutter test
```

## 👨‍💻 Development & Contributing

To maintain code quality, please adhere to the following workflow before opening a Pull Request:

1.  **Analyze the code:** Ensure there are no warnings or errors.
    ```bash
    flutter analyze
    ```
2.  **Format the code:** Enforce standard Dart formatting.
    ```bash
    flutter format .
    ```
3.  **Semantic Commits:** Use standard prefixes for your commits to keep the git history clean and readable:
    * `feat:` New features
    * `fix:` Bug fixes
    * `refactor:` Structural changes without altering behavior
    * `chore:` Updates to dependencies, CI, or tooling

## 📄 License

This project is licensed under the MIT License.
