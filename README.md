# Atomberg Smart Fan Controller

## Overview

This application allows users to securely configure and store their **Atomberg API Key** and **Refresh Token**, which are required to interact with Atomberg’s Smart Fan APIs.

The app follows a **clean architecture** with **Flutter + Bloc** for predictable state management and scalable code structure.

---

## How It Works

1. **User Input**

    * The user enters an **API Key** and **Refresh Token** on the credentials screen.

2. **Validation**

    * Inputs are validated in real time using `AuthCredsBloc`.
    * Field-level errors are shown if any value is missing.

3. **Submission**

    * On tapping **Proceed**, credentials are validated again.
    * A loading state is displayed while saving data.

4. **Persistence**

    * Valid credentials are securely stored using `TokenStore`.
    * On success, the app emits a success state that can be used for navigation.

5. **Error Handling**

    * Validation errors are shown inline.
    * Storage or unexpected errors are handled gracefully.

---

## Installation Instructions

### Prerequisites

* Flutter SDK (latest stable)
* Dart SDK (bundled with Flutter)
* Android Studio or VS Code
* Android Emulator or a physical device

### Steps

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd atomberg_smart_fan_controller
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

## Live Website Link

👉 [Click to visit](https://tejas-g7.github.io/atomberg_smart_fan/)

---

## App Demo Video

🎥 [Click to view / download app demo video](project_demo/app_demo.mp4)

<video width="600" controls>
  <source src="project_demo/app_demo.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
