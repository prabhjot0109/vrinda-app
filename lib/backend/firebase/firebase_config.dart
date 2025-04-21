import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCyZqal48V1nIIwHzQ4TeTZmHq47KaQCiI",
            authDomain: "philosia-vrinda.firebaseapp.com",
            projectId: "philosia-vrinda",
            storageBucket: "philosia-vrinda.firebasestorage.app",
            messagingSenderId: "238778896816",
            appId: "1:238778896816:web:1cba439139162dc99f4675",
            measurementId: "G-BZS4X10V2C"));
  } else {
    await Firebase.initializeApp();
  }
}
