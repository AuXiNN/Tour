import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour/Widgets/custombuttomauth.dart';
import 'package:tour/Widgets/textformfield.dart';
import 'package:tour/AppColors/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  void showInvalidCredentialsDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: 'Invalid Email or Password',
    ).show();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'homepage');
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(58, 27, 15, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text(
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
                    hinttext: "Enter Your Email",
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return "Please Enter An Email";
                      }
                    },
                  ),
                  const SizedBox(height: 40),
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
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async {
                        if (email.text == "") {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                                'Please Write Your Email Then Press Forgot Password',
                          ).show();
                          return;
                        }

                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Success',
                            desc:
                                'An Email Has Been Sent To Reset Your Password!',
                          ).show();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.orange, // Add the desired color
                        ),
                      ),
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
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );

                    if (userCredential.user != null) {
                      Navigator.pushNamed(context, 'homepage');
                    } else {
                      print('User not found or invalid credentials');
                      showInvalidCredentialsDialog(context);
                    }
                  } on FirebaseAuthException catch (e) {
                    print('Error code: ${e.code}');
                    print('Error message: ${e.message}');

                    if (e.code == "invalid-email") {
                      print('Invalid Email.');
                      showInvalidCredentialsDialog(context);
                    } else {
                      // Handle other cases or display a generic error message
                      print('Authentication failed. Please try again.');
                      showInvalidCredentialsDialog(context);
                    }
                  }
                } else {
                  print('Form validation failed');
                }
              },
            ),
            // CustomButtomAuth(
            //   title: "Login",
            //   onPressed: () async {
            //     if (formState.currentState!.validate()) {
            //       try {
            //         final userCredential =
            //             await FirebaseAuth.instance.signInWithEmailAndPassword(
            //           email: email.text,
            //           password: password.text,
            //         );

            //         if (userCredential.user != null) {
            //           Navigator.pushNamed(context, 'homepage');
            //         } else {
            //           print('User not found or invalid credentials');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Error',
            //             desc: 'Invalid email or password',
            //           ).show();
            //         }
            //       } on FirebaseAuthException catch (e) {
            //         print('Error code: ${e.code}');
            //         if (e.code == "invalid-email") {
            //           print('Invalid Email.');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Error',
            //             desc: 'Invalid Email',
            //           ).show();
            //         } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
            //           print('You Entered The Wrong Password.');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Error',
            //             desc: 'You Entered The Wrong Password.',
            //           ).show();
            //         } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
            //           print('No user found for that email.');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Error',
            //             desc: 'No user found for that email.',
            //           ).show();
            //         }
            //       }
            //     } else {
            //       print('Form validation failed');
            //     }
            //   },
            // ),
            const SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              onPressed: () async {
                try {
                  await _handleSignInWithGoogle();
                } catch (e) {
                  print('Error during Google Sign-In: $e');
                }
              },
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'signup');
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

  Future<void> _handleSignInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  
  if (googleUser == null) {
    // User canceled the Google Sign-In process
    return;
  }

  // Sign out the current user to force the Google Sign-In page to appear
  await FirebaseAuth.instance.signOut();

  final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  try {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      // Check if the user already exists in Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .get();

      if (!userDoc.exists) {
        // If the user doesn't exist, create a new document in Firestore
        await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
          'username': userCredential.user!.displayName ?? 'DefaultUsername',
          'email': userCredential.user!.email,
          'bio': 'Default Bio',
          // Add other necessary fields
        });
      }

      Navigator.pushNamed(context, 'homepage');
    } else {
      print('Google Sign-In failed');
    }
  } catch (e) {
    print('Error during Google Sign-In: $e');
  }
}

}
