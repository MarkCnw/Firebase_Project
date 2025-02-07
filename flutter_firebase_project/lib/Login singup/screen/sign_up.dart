import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20singup/Services/authentication.dart';
import 'package:flutter_firebase_project/Login%20singup/screen/home_screen.dart';
import 'package:flutter_firebase_project/Login%20singup/screen/login.dart';
import 'package:flutter_firebase_project/Login%20singup/widget/snack_bar.dart';

import '../widget/button.dart';
import '../widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser() async {
    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
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
                child: Image.asset("images/register.jpg"),
              ),
              TextFieldInpute(
                textEditingController: nameController ,
                hintText: "Enter your namel",
                icon: Icons.person,
              ),
              TextFieldInpute(
                textEditingController: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              TextFieldInpute(
                textEditingController: passwordController,
                hintText: "Enter your password",
                isPass:  true,
                icon: Icons.lock,
              ),
              MyButton(onTab: signUpUser, text: "Sign Up"),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                    child: const Text(
                      "Login",
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

