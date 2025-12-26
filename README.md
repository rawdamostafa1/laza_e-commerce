# Laza – E-commerce Mobile App

## 1. Project Overview
- **Project Name:** Laza – E-commerce Mobile App  
- **Platforms:** iOS & Android (Flutter – single codebase)  
- **Goal:** Build a simplified, functional e-commerce MVP based on the Laza UI Kit.  

**Features implemented in MVP:**  
- Sign up / log in using Firebase Authentication  
- Browse products (Platzi Fake Store API)  
- View product details  
- Add/remove from cart  
- Add/remove favorites  
- Complete a mock checkout  
- Persist minimal user data in Firestore (favorites + cart)  

---

## 2. Repository Structure
/lib
/assets
/screenshots
/test
/appium_tests
/docs
/results
/builds
/apk
/ios_instructions
/video
README.md
firebase.json
firestore.rules
firebase_setup.md

---

## 3. Flutter & Project Dependencies Installation

1. **Install Flutter:**  
   [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)

2. **Clone the repository:**  
```bash
git clone <repo_url>
cd laza_app
Install dependencies:

flutter pub get


Run the app:

flutter run

4. Firebase Setup

Follow the detailed guide in firebase_setup.md

Make sure to:

Enable Firebase Authentication (Email/Password)

Enable Cloud Firestore

Add Android & iOS app config files:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Deploy Firestore rules from firestore.rules:

firebase deploy --only firestore:rules

5. Firestore Rules Installation

File: firestore.rules

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Carts
    match /carts/{userId}/items/{itemId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Favorites
    match /favorites/{userId}/items/{itemId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

  }
}

6. Running Android & iOS Builds

Android:

flutter run


iOS:

flutter run

7. Running Appium Tests

Ensure Appium server is running:

appium


Run the test scripts:

node appium_tests/auth_test.js
node appium_tests/cart_test.js


Test results (logs, screenshots, summary) will be saved in /docs/results.

8. Screenshots

All app screenshots are located in /screenshots folder.
Example screenshots:

home_screen.png

product_details.png

cart_screen.png

favorites_screen.png

9. Notes

Firestore stores minimal user data only (users, carts, favorites)

Product data is fetched from Platzi Fake Store API

Checkout is mock (no real payment integration)

App follows simple, modular structure for readability