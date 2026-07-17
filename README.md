# Custom UI & Navigation Project

This repository contains the deliverables for Checkpoints 2, 3, and 4 of the application assignment.

## Features Implemented
* **Checkpoint 2 (Custom UI):** Created a scrollable `ListView` containing a custom card widget (using `Stack`), an informational block (`Column` and `Row`), and custom reusable action buttons.
* **Checkpoint 3 (Navigation):** Implemented declarative cross-screen navigation between the main screen and a newly added `DetailsScreen` using the `go_router` package.
* **Checkpoint 4 (Responsive Layout):** Added support for multiple screen sizes using a `LayoutBuilder`. It automatically switches to a split-screen desktop layout for screens wider than 600px.

## Packages Used
* `go_router: ^14.0.0` (or the latest compatible version)

## How to Run Locally
1. Clone this repository.
2. Run `flutter pub get` in the project root to fetch dependencies.
3. Target Chrome web or an emulator.
4. Execute `flutter run` to launch the application.