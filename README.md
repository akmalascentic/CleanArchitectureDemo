# Clean Architecture Demo

A Flutter library catalogue that demonstrates a feature-first Clean Architecture
implementation. It displays books from a bundled JSON file and separates UI,
application state, domain rules, and data access.

## Requirements

- Git
- [FVM](https://fvm.app/) installed and available on `PATH`
- Flutter `3.47.1`, installed by FVM from this repository's `.fvmrc`
- A development environment for the target platform:
  - Android: Android Studio, Android SDK, and an emulator or physical device
  - iOS (macOS only): Xcode, CocoaPods, and an iOS Simulator or device
  - Web: Chrome
  - macOS, Windows, or Linux: the platform-specific Flutter desktop toolchain

The application declares Dart SDK compatibility with `^3.13.1`. Use the Dart
SDK bundled with the FVM-managed Flutter release rather than a separately
installed Flutter SDK.

## Install FVM

If FVM is not installed already, install it with one of the following options:

```bash
# macOS
brew tap leoafarias/fvm
brew install fvm

# Any platform with Dart installed
dart pub global activate fvm
```

For the Dart installation method, ensure the Dart pub-cache bin directory is
on `PATH`, then confirm the installation:

```bash
fvm --version
```

## Get started

From a fresh clone, run:

```bash
git clone <repository-url>
cd CleanArchitectureDemo

# Installs the Flutter version specified in .fvmrc (3.47.1).
fvm install

# Confirms the Flutter and Dart versions selected by FVM.
fvm flutter --version

# Fetches package dependencies.
fvm flutter pub get

# Generates localization source from lib/l10n/*.arb.
fvm flutter gen-l10n

# Generates Riverpod provider code, including *.g.dart files.
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Run the application on a connected device or simulator:

```bash
# List available targets.
fvm flutter devices

# Launch on the selected/default target.
fvm flutter run

# Examples of explicit targets.
fvm flutter run -d chrome
fvm flutter run -d macos
```

Use `fvm flutter ...` for every Flutter command in this project. This ensures
all contributors use the version pinned in `.fvmrc`.

## Common commands

```bash
# Run all tests.
fvm flutter test

# Analyze the project using flutter_lints and riverpod_lint.
fvm flutter analyze

# Format Dart source and tests.
fvm dart format lib test

# Continuously regenerate Riverpod code while editing providers.
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Rebuild generated code once after changing annotations or model generators.
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Remove build artifacts and restore packages.
fvm flutter clean
fvm flutter pub get
```

After `flutter clean`, rerun `fvm flutter gen-l10n` and the `build_runner`
command before building or testing.

## Architecture

The source is organized by feature and layer:

```text
lib/
├── core/
│   ├── error/          # Shared Failure types
│   ├── extensions/     # BuildContext localization extension
│   └── usecase/        # UseCase contract and NoParams
├── features/
│   └── book/
│       ├── data/       # JSON model, local data source, repository implementation
│       ├── domain/     # Book entity, repository contract, GetBooks use case
│       └── presentation/
│           ├── providers/ # Riverpod dependency graph and async book-list state
│           ├── screens/   # BookListScreen
│           └── widgets/   # BookItem
├── l10n/               # ARB input and generated localizations
└── main.dart           # ProviderScope and MaterialApp setup
```

### Book loading flow

1. `LibraryApp` creates a Riverpod `ProviderScope` and shows
   `BookListScreen`.
2. `BookListScreen` watches `bookListProvider`, rendering a loading indicator,
   an error message, or a list of `BookItem` widgets.
3. `BookList` reads `getBooksUseCaseProvider` and invokes `GetBooks` with
   `NoParams`.
4. `GetBooks` depends only on the `BookRepository` domain contract.
5. `BookRepositoryImpl` requests models from `BookLocalDataSource`.
6. `BookLocalDatasourceImpl` waits for the demo delay, reads
   `assets/data/books.json` through Flutter's `rootBundle`, and maps each JSON
   object to a `BookModel`.
7. `BookModel` extends the domain `Book` entity, so the repository can return
   the loaded models as domain books. Data-source exceptions become
   `CacheFailure` values using `fpdart`'s `Either`.

Pulling down on the book list invalidates `bookListProvider`, which starts the
loading flow again.

## State, localization, and assets

- **State management:** `flutter_riverpod` manages dependency injection and
  asynchronous screen state. Provider declarations in
  `book_list_provider.dart` are generated into
  `book_list_provider.g.dart`.
- **Error handling:** domain and data operations return
  `Either<Failure, List<Book>>`. The presentation provider converts a failure
  into an error state for the screen.
- **Localization:** English strings are defined in `lib/l10n/app_en.arb`.
  Flutter generates `l10n.dart` and `l10n_en.dart`; access them with
  `context.l10n`.
- **Assets:** the book catalogue is at `assets/data/books.json`, and the app
  theme uses the Arimo font files in `assets/fonts/`.

## Adding or changing a feature

1. Define business objects and repository contracts in the feature's `domain`
   layer.
2. Add models, data sources, and contract implementations in `data`.
3. Add Riverpod providers and UI in `presentation`.
4. Run `fvm flutter pub run build_runner build --delete-conflicting-outputs`
   after adding or changing `@riverpod` declarations.
5. Run `fvm flutter gen-l10n` after changing ARB localization files.
6. Add or update tests, then run `fvm flutter test` and
   `fvm flutter analyze`.
