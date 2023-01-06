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
        return macos;
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
    apiKey: 'AIzaSyBQffZpeaswpV0HZWTEuQunp2nLPYSLy3k',
    appId: '1:124554484756:web:c4e85e7b680bef3856db01',
    messagingSenderId: '124554484756',
    projectId: 'mytestapp-project-app',
    authDomain: 'mytestapp-project-app.firebaseapp.com',
    storageBucket: 'mytestapp-project-app.appspot.com',
    measurementId: 'G-HR67BF8CBB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGc_M5ZY7dlDq4C2CsCwL_5FzV8ooiJvs',
    appId: '1:124554484756:android:d2028334f22b74e856db01',
    messagingSenderId: '124554484756',
    projectId: 'mytestapp-project-app',
    storageBucket: 'mytestapp-project-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdZB75-Z2dxrdlnMdXxOF9rPlUPkT_6lA',
    appId: '1:124554484756:ios:62b1bc528d2c121056db01',
    messagingSenderId: '124554484756',
    projectId: 'mytestapp-project-app',
    storageBucket: 'mytestapp-project-app.appspot.com',
    iosClientId: '124554484756-0n07fmo63h25i161k5pipe7khh01gllr.apps.googleusercontent.com',
    iosBundleId: 'com.example.mytestapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdZB75-Z2dxrdlnMdXxOF9rPlUPkT_6lA',
    appId: '1:124554484756:ios:62b1bc528d2c121056db01',
    messagingSenderId: '124554484756',
    projectId: 'mytestapp-project-app',
    storageBucket: 'mytestapp-project-app.appspot.com',
    iosClientId: '124554484756-0n07fmo63h25i161k5pipe7khh01gllr.apps.googleusercontent.com',
    iosBundleId: 'com.example.mytestapp',
  );
}