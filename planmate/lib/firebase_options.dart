// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC7koORXw2AEOWuz0gK1U0MQWXaEj5f3u4',
    appId: '1:404691657162:web:32b964959b077114d72f33',
    messagingSenderId: '404691657162',
    projectId: 'realtime-database-e48e2',
    authDomain: 'realtime-database-e48e2.firebaseapp.com',
    databaseURL: 'https://realtime-database-e48e2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realtime-database-e48e2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVbVJPpFZhYYYjKgjcfcvEWyhGFT8y5qI',
    appId: '1:404691657162:android:089b275be7f46ac4d72f33',
    messagingSenderId: '404691657162',
    projectId: 'realtime-database-e48e2',
    databaseURL: 'https://realtime-database-e48e2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realtime-database-e48e2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPyDEoJqAtzGjyPZ7RkPu5BL_fKG6QNZk',
    appId: '1:404691657162:ios:8aa0d9397efbe3acd72f33',
    messagingSenderId: '404691657162',
    projectId: 'realtime-database-e48e2',
    databaseURL: 'https://realtime-database-e48e2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realtime-database-e48e2.firebasestorage.app',
    iosBundleId: 'com.example.planmate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPyDEoJqAtzGjyPZ7RkPu5BL_fKG6QNZk',
    appId: '1:404691657162:ios:8aa0d9397efbe3acd72f33',
    messagingSenderId: '404691657162',
    projectId: 'realtime-database-e48e2',
    databaseURL: 'https://realtime-database-e48e2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realtime-database-e48e2.firebasestorage.app',
    iosBundleId: 'com.example.planmate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC7koORXw2AEOWuz0gK1U0MQWXaEj5f3u4',
    appId: '1:404691657162:web:36501e11a8e46a49d72f33',
    messagingSenderId: '404691657162',
    projectId: 'realtime-database-e48e2',
    authDomain: 'realtime-database-e48e2.firebaseapp.com',
    databaseURL: 'https://realtime-database-e48e2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realtime-database-e48e2.firebasestorage.app',
  );
}
