# Flutter Task Manager — Dart 3 compatibility updates

The project source has been updated for Dart null safety and newer Flutter APIs:
- Updated task model null-safety and constructor parameters.
- Updated SQLite database initialization and async table creation.
- Replaced the old `toast` API with `fluttertoast`.
- Replaced removed `FlatButton` widgets with `TextButton`.
- Updated nullable form/date values and task-list handling.
- Updated URL launching to `launchUrl(Uri.parse(...))`.

## Run on your computer

From this project directory in PowerShell:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter run
```

`pubspec.lock` and `.dart_tool` are intentionally omitted so your local Flutter installation can resolve dependencies afresh.

Note: this environment does not have the Flutter/Dart SDK installed, so run the commands above locally to confirm analyzer/build results. If Android Gradle configuration reports a separate toolchain error, share that output next.
