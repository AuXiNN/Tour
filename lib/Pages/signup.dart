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
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // State variable for the main password field
  bool _isPasswordVisible = false;

  // State variable for the confirm password field
  bool _isConfirmPasswordVisible = false;

  // Function to toggle main password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Function to toggle confirm password visibility
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  // Regular expression for email validation
 final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.(com|net|org|edu|gov|mil|co.uk)$',
);

  // Regular expression for password validation
final RegExp passwordRegex = RegExp(
  r'^(?=.*[A-Z])(?=.*\d.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
);



  String? validateEmail(String? value) {
  if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || !passwordRegex.hasMatch(value)) {
      return "Password must contain at least 8 characters, including an uppercase letter, a special character, and 3 numbers";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (password.text != confirmPassword.text) {
      return "Passwords do not match";
    }
    return null;
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
                  const Center(
                    child: Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign Up to Continue Using JoTour',
                    style: TextStyle(color: Color.fromARGB(255, 119, 116, 116)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'First Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your First Name",
                    mycontroller: firstName,
                    validator: (val) {
                      if (val == "") {
                        return "Please Enter First Name";
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Last Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your Last Name",
                    mycontroller: lastName,
                    validator: (val) {
                      if (val == "") {
                        return "Please Enter Last Name";
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                      hinttext: "Enter Your Email",
                      mycontroller: email,
                      validator: validateEmail),
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
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Confirm Your Password",
                    mycontroller:
                        confirmPassword, // Assuming you have a TextEditingController for confirm password
                    obscureText: !_isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                    validator: validateConfirmPassword,
                  ),
                  const SizedBox(height: 80),
                  
                ],
              ),
            ),
            CustomButtomAuth(
                //create a user
                title: "SignUp",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    print('First Name: ${firstName.text}');
                    print('Last Name: ${lastName.text}');
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );

                      // after creating the user, ccreat a new document in cloud firestore called Users
                      if (firstName.text.isNotEmpty &&
                          lastName.text.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userCredential.user!.email)
                            .set({
                          'first_name': firstName.text,
                          'last_name': lastName.text,
                          'bio': 'Empty bio...',
                        });
                      } else {
                        print('First name or last name is empty');
                        // Handle empty first name or last name case
                      }

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
            const SizedBox(height: 40),
           
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
