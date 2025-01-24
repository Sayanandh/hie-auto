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
          'DefaultFirebaseOptions are not configured for Linux. '
          'Run the FlutterFire CLI to set it up.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7vYcgxHrHiVEXc3t6otJ99GAEToy27tk',
    appId: '1:192986937504:web:e1d02427340492079bf1c5',
    messagingSenderId: '192986937504',
    projectId: 'hye-auto',
    authDomain: 'hye-auto.firebaseapp.com',
    storageBucket: 'hye-auto.appspot.com',
    measurementId: 'G-M3J2HFWQZ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2xCq9HMVIICuiRtWPsxdXJcWAtMPUJd0',
    appId: '1:192986937504:android:1e52a35bfce17af39bf1c5',
    messagingSenderId: '192986937504',
    projectId: 'hye-auto',
    storageBucket: 'hye-auto.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQsjduY7b6Ka1zic6OY206si1vdY0uzr8',
    appId: '1:192986937504:ios:b71f926a0d65b92a9bf1c5',
    messagingSenderId: '192986937504',
    projectId: 'hye-auto',
    storageBucket: 'hye-auto.appspot.com',
    iosBundleId: 'com.example.haiautoUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQsjduY7b6Ka1zic6OY206si1vdY0uzr8',
    appId: '1:192986937504:ios:b71f926a0d65b92a9bf1c5',
    messagingSenderId: '192986937504',
    projectId: 'hye-auto',
    storageBucket: 'hye-auto.appspot.com',
    iosBundleId: 'com.example.haiautoUser',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7vYcgxHrHiVEXc3t6otJ99GAEToy27tk',
    appId: '1:192986937504:web:d8ff79085cba308c9bf1c5',
    messagingSenderId: '192986937504',
    projectId: 'hye-auto',
    authDomain: 'hye-auto.firebaseapp.com',
    storageBucket: 'hye-auto.appspot.com',
    measurementId: 'G-SV21KM1M5X',
  );
}
