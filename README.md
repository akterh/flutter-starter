# 📷 CameraSync App

Welcome to the **CameraSync App**, a high-performance Flutter application featuring an **Advanced Camera Module** with manual tap-to-focus, pinch-and-slider zoom controls, and a **Resilient Offline-First Sync Engine**. Built with **Feature-First Clean MVVM Architecture**, **BLoC/Cubit state management**, **Hive local persistence**, and **background execution**, CameraSync captures image batches and automatically synchronizes them with intelligent network stability monitoring and autonomous retry mechanisms.

---

## 🚀 Getting Started

This project uses **Flutter** with **flavor-based environments** for smooth development, staging, and production lifecycle management.

### ✅ Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (>= 3.0.0)
- Dart SDK
- Android Studio / VSCode
- Xcode (for iOS development)
- Firebase CLI (if using Firebase services)
- Git

---

## 🧪 Flavors and Build Commands

The app supports 3 environments:

- 🔧 `development`
- 🚧 `staging`
- 🚀 `production`

### ➤ Run the App (Based on Flavor)

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart

➤ Build APK or App Bundle

# Development
flutter build apk --flavor development --target lib/main_development.dart
flutter build appbundle --flavor development --target lib/main_development.dart

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart
flutter build appbundle --flavor staging --target lib/main_staging.dart

# Production
flutter build apk --flavor production --target lib/main_production.dart
flutter build appbundle --flavor production --target lib/main_production.dart


```
### ⚙️ Code Generation
Some parts of the app use code generation (e.g., dependency injection, localization, JSON parsing):
```bash
flutter pub run build_runner build --delete-conflicting-outputs

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs

flutter packages pub run build_runner build
```
### 📦 Key Dependencies
| Package                          | Purpose                                                 |
| -------------------------------- | ------------------------------------------------------- |
| `flutter_bloc` & `bloc`          | State management (Cubit / BLoC pattern)                |
| `camera`                         | Hardware camera control, zoom levels & manual focus     |
| `hive` & `hive_flutter`          | Local database persistence for batches & offline queue  |
| `flutter_background`             | Resilient background execution for upload sync          |
| `internet_connection_checker_plus` & `connectivity_plus` | Enhanced network stability & latency monitoring |
| `dio`                            | API networking and HTTP clients                         |
| `dartz`                          | Functional programming & `Either<ApiFailure, T>` results|
| `get_it` + `injectable`          | Dependency injection and service locator               |
| `flutter_screenutil`             | Responsive adaptive UI layout                           |
| `easy_localization`              | Internationalization & localization                     |

---

### 📂 Project Structure
```plaintext
lib/
├── core/                         # Cross-cutting infrastructure & shared logic
│   ├── app/                      # App widget, DI initialization & flavor configs
│   ├── components/               # Reusable custom UI widgets
│   ├── constants/                # Theme colors, text styles, and assets
│   ├── local_database/           # Hive database service, adapters & schemas
│   ├── router/                   # Named route definitions & route generator
│   └── services/                 # Network stability & background sync services
│
├── data/                         # Global data access layer
│   └── network/                  # Dio client, API request abstractions & errors
│
└── features/                     # Feature modules (Feature-First Clean MVVM)
    ├── camera/                   # Camera preview, zoom gestures, tap-to-focus
    │   ├── cubit/                # CameraCubit & CameraFeatureState
    │   ├── view/                 # CameraPreviewScreen
    │   └── widgets/              # FocusReticle, ZoomControls
    │
    └── sync/                     # Resilient Sync Engine & Upload Manager
        ├── cubit/                # SyncCubit & SyncFeatureState
        ├── models/               # SyncBatch & SyncImage Hive entities
        ├── repository/           # SyncRepository interface & implementation
        ├── services/             # ResilientSyncEngine autonomous queue
        ├── view/                 # UploadManagerScreen
        └── widgets/              # BatchUploadCard, SyncHeaderCard
```