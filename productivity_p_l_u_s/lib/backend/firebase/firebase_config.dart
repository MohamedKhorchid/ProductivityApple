import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB4VYSXTtR0dlHwY6486mRB79ffEOUo7Is",
            authDomain: "productivityplus-9470e.firebaseapp.com",
            projectId: "productivityplus-9470e",
            storageBucket: "productivityplus-9470e.firebasestorage.app",
            messagingSenderId: "1053388144198",
            appId: "1:1053388144198:web:b3afda48e46cab22f95447",
            measurementId: "G-M5FMY23YQ3"));
  } else {
    await Firebase.initializeApp();
  }
}
