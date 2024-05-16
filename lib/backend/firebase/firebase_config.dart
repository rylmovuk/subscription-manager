import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBvVHdhgMpwmed4ItrQnExQ_BF6GnMGJqA",
            authDomain: "subscriptions-manager-b1027.firebaseapp.com",
            projectId: "subscriptions-manager-b1027",
            storageBucket: "subscriptions-manager-b1027.appspot.com",
            messagingSenderId: "669711345810",
            appId: "1:669711345810:web:ac04b07448dc4e318ede4b",
            measurementId: "G-T9T63JREKB"));
  } else {
    await Firebase.initializeApp();
  }
}
