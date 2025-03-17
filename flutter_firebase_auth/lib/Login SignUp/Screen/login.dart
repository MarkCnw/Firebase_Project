import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Login%20SignUp/Widget/button.dart';
import 'package:flutter_firebase_auth/Login%20SignUp/Widget/text_field.dart';
import 'package:flutter_firebase_auth/Login%20With%20Google/google_auth.dart';
import 'package:flutter_firebase_auth/Password/forgot_password.dart';
import 'package:flutter_firebase_auth/Phone/phone_login.dart';

import '../Service/authentication.dart';
import '../Widget/snackbar.dart';
import 'home_screen.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthServicews().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: height / 2.7,
              child: Image.asset('images/picture2.png'),
            ),
            TextFieldInput(
                textEditingController: emailController,
                hintText: "Enter your email",
                icon: Icons.email),
            TextFieldInput(
              isPass: true,
              textEditingController: passwordController,
              hintText: "Enter your password",
              icon: Icons.lock,
            ),
            MyButton(onTab: loginUser, text: "Log In"),
            ForgotPassword(),
            SizedBox(height: height / 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                  onPressed: ()async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.network(
                          "https://logos-world.net/wp-content/uploads/2020/09/Google-Symbol.png",
                          height: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "continue with Google",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  )),
            ),
            PhoneAuthentication(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
