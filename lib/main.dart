import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tour/auth/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
     MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Login(),
    ),
  );
}
