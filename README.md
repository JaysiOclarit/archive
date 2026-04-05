# The Archive (archive)

A Flutter + Firebase app concept for building a curated personal archive—think “folders/collections + saved bookmarks” with authentication and a clean editorial-style UI.

This repository is a Flutter application using:
- **Firebase Auth** for sign-in/sign-up (and password reset hooks)
- **Cloud Firestore** for storing user data and app content (collections/folders + bookmarks)
- **flutter_bloc (Cubit)** for state management
- **go_router** for navigation/routing

---

## What is this project?

**The Archive** is a multi-platform Flutter app (Android, iOS, Web, Desktop supported by Flutter project scaffolding) that provides a curated experience for:
- landing / welcome screen
- authentication (login & signup)
- managing “Collections” (folders) and “Bookmarks” stored in Firestore

> Note: Some UI actions (e.g., “Continue with Google”, “Forgot password?”, “Sign Up” button routing) appear to be present in the UI but may still need wiring in code depending on your current implementation.

---

## Features (current codebase)

### Authentication
- Email/password login via Firebase Auth
- Fetches a custom user profile after authentication (from Firestore)
- Logout
- Reset password function exists in the `AuthCubit`

### Collections (Folders)
- Load collections from Firestore
- Add / update / delete collections
- In-memory search over loaded collections (no extra Firestore reads)

### Bookmarks
- Load all bookmarks
- Load bookmarks by folder/collection
- Add / update / delete bookmarks

---

## Tech Stack

- **Flutter** (Dart SDK constraint: `^3.11.4`)
- **Firebase**
  - `firebase_core`
  - `firebase_auth`
  - `cloud_firestore`
- **State management:** `flutter_bloc` (Cubit)
- **Routing:** `go_router`
- **UI/Styling:** `google_fonts`, custom theme tokens, reusable components

---

## Project Structure (important folders)

```txt
lib/
  business_logic/
    cubits/
      auth_cubit.dart
      bookmark_cubit.dart
      collection_cubit.dart
      ...state files...
  core/
    router.dart
    theme/
    assets/
  data/
    dataproviders/
    models/
    repositories/
      auth_repository.dart
      bookmark_repository.dart
      collection_repository.dart
  presentation/
    screens/
      archive_landing_screen.dart
      login_screen.dart
      signup_screen.dart
    modules/
    components/
    elements/