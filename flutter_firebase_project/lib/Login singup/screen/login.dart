import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20singup/screen/sign_up.dart';
import 'package:flutter_firebase_project/Login%20singup/widget/button.dart';
import 'package:flutter_firebase_project/Login%20singup/widget/text_field.dart';

import '../Services/authentication.dart';
import '../widget/snack_bar.dart';
import 'Home_screen.dart';

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
  void loginUsers() async {
    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,

    );
    if (res == "successfull signed up") {
      setState(() {
        setState(() {
          isLoading = true;
        });
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen()
        ));
    }else{
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
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
              child: Image.asset("images/login.jpg"),
            ),
            TextFieldInpute(
              textEditingController: emailController,
              hintText: "Enter your email",
              icon: Icons.email,
            ),
            TextFieldInpute(
              isPass: true,
              textEditingController: passwordController,
              hintText: "Enter your password",
              icon: Icons.lock,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
            MyButton(onTab: loginUsers, text: "Log In"),
            SizedBox(
              height: height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
