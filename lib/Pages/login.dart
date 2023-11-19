
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour/Widgets/custombuttomauth.dart';

import 'package:tour/Widgets/textformfield.dart';

import 'package:tour/AppColors/colors.dart';

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

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(                             //Contains the entire login UI, including email, password fields, and the 'Forgot Password?' link.
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(             //A TextButton allowing users to skip login and navigate to the homepage.
                        onPressed:  () {
                        Navigator.of(context).pushReplacementNamed("homepage");
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color:   Color.fromRGBO(58, 27, 15, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text(             
                      'Login',                     // A centered bold text widget indicating the login page.
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
                    'Login to Continue Using The App',             // Text describing the purpose of login.
                    style: TextStyle(color: Color.fromARGB(255, 119, 116, 116)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(                                  // Input fields for email and password using CustomTextForm.
                      hinttext: "Enter Your Email",
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Please Enter An Email";
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                      hinttext: "Enter Your Password",
                      mycontroller: password,
                      obscureText: true,
                      validator: (val) {
                        if (val == "") {
                          return "Please Enter A Password";
                        }
                      }),
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
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } on FirebaseAuthException catch (e) {
                      print('Error code: ${e.code}'); // Add this print statement
                      if (e.code == "invalid-email") {
                        print('Invalid Email.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Invalid Email',
                        ).show();
                      } else if (e.code == 'wrong-password') {
                        print('You Entered The Wrong Password.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'You Entered The Wrong Password.',
                        ).show();
                      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
                        print('No user found for that email.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'No user found for that email.',
                        ).show();
                      }
                    }
                  } else {
                    print('Not Valid');
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
              color: AppColors.buttomcolor,
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

                  //   try {
                  //     UserCredential userCredential = await FirebaseAuth
                  //         .instance
                  //         .signInWithEmailAndPassword(
                  //             email: email.text,
                  //             password: email.text);
                  //   } on FirebaseAuthException catch (e) {
                  //     if (e.code == 'user-not-found') {
                  //       print('No user found for that email.');
                  //     } else if (e.code == 'wrong-password') {
                  //       print('Wrong password provided for that user.');
                  //     }
                  //   }
                  // } else {
                  //   print('Not Valid');
                  // }