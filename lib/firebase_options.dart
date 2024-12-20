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
    apiKey: 'AIzaSyDK27s7d0EMFCW0uniLMQKhPLcihELhikQ',
    appId: '1:308407259586:web:fc54a23c287b50e4d4865b',
    messagingSenderId: '308407259586',
    projectId: 'words-news-dd60a',
    authDomain: 'words-news-dd60a.firebaseapp.com',
    storageBucket: 'words-news-dd60a.firebasestorage.app',
    measurementId: 'G-71CRD2ZREF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0wwL1I0QndzNbQxt4e1N-aSxFz7LiPu0',
    appId: '1:308407259586:android:52f75e02a8be752ad4865b',
    messagingSenderId: '308407259586',
    projectId: 'words-news-dd60a',
    storageBucket: 'words-news-dd60a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPIif-WApLRLgxvvRMkkuy9fZ0UXiVzEk',
    appId: '1:308407259586:ios:335399b154b30f0ad4865b',
    messagingSenderId: '308407259586',
    projectId: 'words-news-dd60a',
    storageBucket: 'words-news-dd60a.firebasestorage.app',
    iosBundleId: 'com.pk.news',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPIif-WApLRLgxvvRMkkuy9fZ0UXiVzEk',
    appId: '1:308407259586:ios:5822c41657e79ae1d4865b',
    messagingSenderId: '308407259586',
    projectId: 'words-news-dd60a',
    storageBucket: 'words-news-dd60a.firebasestorage.app',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDK27s7d0EMFCW0uniLMQKhPLcihELhikQ',
    appId: '1:308407259586:web:faf3890c4647e436d4865b',
    messagingSenderId: '308407259586',
    projectId: 'words-news-dd60a',
    authDomain: 'words-news-dd60a.firebaseapp.com',
    storageBucket: 'words-news-dd60a.firebasestorage.app',
    measurementId: 'G-6CTGFP0NZH',
  );
}
