import 'package:customer/app/routes.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dependency_injection/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB40cRSnxaU96FtWY0I8ekT8hkT740Ib34",
        authDomain: "fire-setup-e7514.firebaseapp.com",
        projectId: "fire-setup-e7514",
        storageBucket: "fire-setup-e7514.firebasestorage.app",
        messagingSenderId: "35030190086",
        appId: "1:35030190086:web:ae1e0a24b0add72040db87",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  GlobalBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
