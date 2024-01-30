# Instagram_Clone_SwiftUI
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ElvisWong)

## About This Project 
Build Instagram by using SwiftUI and Firebase

## TODO
- [ ] Reel
- [ ] Story
- [ ] Chat
- [ ] Video recording and photo capture function
- [ ] Improve upload UI
- [ ] Login Screen

## Requirements
- iOS 17+
- Xcode 15.0.0+
- Swift 5+
- Firebase (Authentication, Firestore, Storage)

## Usage
1. Clone the project to your local directory
2. [Setup firebase (follow the steps to setup your firebase)](https://firebase.google.com/docs/ios/setup)

### Test on Live Server / Emulators
If you want to test it on live server, please change the `Build Configuration` to `Debug`.

Otherwise, keep the `Build Configuration` to `Emulators`
<img width="943" alt="截圖 2023-12-04 下午4 32 02" src="https://github.com/ElvisWong213/Instagram_Clone_SwiftUI/assets/40566101/76b89672-808e-45a8-b408-7e4608ab4ab6">

### Setup Emulators
If you test it on emulators. Please follow the guide to [Setup the emulator](https://firebase.google.com/docs/emulator-suite/install_and_configure)

## Firebase Configuration 

1. Firestore rules
```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
    match /users/{user} {
      allow read, write: if request.auth != null;
    }
    match /usernames/{username} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```
2. Storage rules
```
rules_version = '2';

// Craft rules based on data in your Firestore database
// allow write: if firestore.get(
//    /databases/(default)/documents/users/$(request.auth.uid)).data.isAdmin;
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}

```
