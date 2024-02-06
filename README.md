# CheckBox Mobile App

A TODO management app built with Flutter and Firebase, real-time syncing, and customizable TODO categories."

## Features

- User Authentication (Email/Password, Google Sign-In)
- Cached Authentication for user friendliness
- Real-time TODO synchronization with Firebase Firestore
- Create, Read, Update, Delete (CRUD) operations for TODOs
- Search functionality for easy navigation
- Customizable categories and tags for TODOs

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (preferably Android Studio or Visual Studio Code)
- Firebase account

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/akifatakan/checkbox-mobile-app.git
```

2. **Navigate to the project directory**

```bash
cd checkbox-mobile-app
```

3. **Install Dependencies**

```bash
flutter pub get
```

4. **Setup Firebase**
- Create a Firebase project in the Firebase console.
- Add your app to the Firebase project and download the google-services.json (for Android) and GoogleService-Info.plist (for iOS).
- Place the downloaded files in the appropriate directories (android/app and ios/Runner).

5. **Enable the required Firebase services**
- Enable Firebase Authentication and configure the sign-in methods (Email/Password, Google).
- Create a Firestore database.

6. **Run the app**

```bash
flutter run
```

**Contact**

Akif Atakan Yılmaz - akifatakan.yilmaz@gmail.com

