import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour/components/custombuttomauth.dart';
import 'package:tour/components/customlogoauth.dart';
import 'package:tour/components/textformfield.dart';

import 'package:tour/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();



  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.primaryColor,
      body: Container(
        
        padding: const EdgeInsets.all(20),
        
        child: ListView(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50),
                  const CustomLogoAuth(),
                  const SizedBox(height: 20),
                  const Center(
                    child:   Text(
                      'Login',
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  const Text(
                    'Login to Continue Using The App',
                    style: TextStyle(color: Color.fromARGB(255, 119, 116, 116)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                      hinttext: "Enter Your Email", mycontroller: email),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                      hinttext: "Enter Your Password", mycontroller: password),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      'Forget Password ?',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtomAuth(
                title: "Login",
                
                onPressed: () async {
                  try {
                    
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    Navigator.of(context).pushReplacementNamed("homepage");

                  } on FirebaseAuthException catch (e) {
                    if (e.code == "user-not-found") {
                      print('No user found for that email.');

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'No user found for that email.',
                      ).show();

                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                       AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Wrong password provided for that user.',
                      ).show();

                    }
                  }
                
                }),
            const SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              onPressed: () {},
              textColor: Colors.white,
              color: AppColors.buttom,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "images/google.png",
                    width: 25,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            // ),
            // const Text(
            //   "Don't Have An Account? Reguster",
            //   textAlign: TextAlign.center,
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don't Have An Account? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
