import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tour/Pages/login.dart';
import 'package:tour/Pages/signup.dart';
import 'package:tour/Pages/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp ({super.key});
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('==========================User is currently signed out!');
    } else {
      print('==========================User is signed in!');
    }
  });
    super.initState();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser== null ? const Login() : const HomePage(),
      routes: {
        "signup" :(context) => const SignUp(),
        "login" : (context) => const Login(),
        "homepage" :(context) => const  HomePage(),
        
        
      },
    );
  }

}

