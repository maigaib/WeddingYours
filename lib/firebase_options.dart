// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyADOUZyyIcuagVU8aCUi0AvowidKQK2uu4',
    appId: '1:44149612105:web:727f946d4a5f756cb8a998',
    messagingSenderId: '44149612105',
    projectId: 'wedding-yours',
    authDomain: 'wedding-yours.firebaseapp.com',
    storageBucket: 'wedding-yours.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYgBCKN6HHgDE1v4niH1gDdSGNqcQ1IVE',
    appId: '1:44149612105:android:46217ed0244d3185b8a998',
    messagingSenderId: '44149612105',
    projectId: 'wedding-yours',
    storageBucket: 'wedding-yours.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsQbCxdzO9x6AV62tF9HNwaApJen1klR8',
    appId: '1:44149612105:ios:8d0c720fd5d7c7e2b8a998',
    messagingSenderId: '44149612105',
    projectId: 'wedding-yours',
    storageBucket: 'wedding-yours.appspot.com',
    iosBundleId: 'com.example.appWeddingYours',
  );
}
