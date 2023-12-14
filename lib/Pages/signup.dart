import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour/Widgets/custombuttomauth.dart';
import 'package:tour/Widgets/customlogoauth.dart';
import 'package:tour/Widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../AppColors/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'SignUp',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  const Text(
                    'SignUp to Continue Using The App',
                    style: TextStyle(color: Color.fromARGB(255, 119, 116, 116)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your username",
                    mycontroller: username,
                    validator: (val) {
                      if (val == "") {
                        return ("Please Enter Username");
                      } else if (val!.length < 4) {
                        return ("username must be atleast 4 characters long");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return ("Please Enter Email");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: password,
                    validator: (val) {
                      if (val == "") {
                        return ("Please Enter Password");
                      }
                    },
                  ),
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
                //create a user
                title: "SignUp",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      UserCredential userCredential = 
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      // after creating the user, ccreat a new document in cloud firestore called Users
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(userCredential.user!.email)
                          .set({
                            'username' : username.text, // initial username
                            'bio' : 'Empty bio...', // initally empty bio

                          });
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        print('Invalid Email');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Invalid Email',
                        ).show();
                      }
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The password provided is too weak.',
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The account already exists for that email.',
                        ).show();
                      } else {
                        // Handle other errors
                        print('Unknown error occurred: ${e.code}');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }),
            const SizedBox(height: 20),
            const SizedBox(
              height: 10,
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
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Already Have An Account? "),
                      TextSpan(
                        text: "Login",
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
