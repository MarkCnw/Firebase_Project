
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20singup/screen/login.dart';
import 'package:flutter_firebase_project/Login%20singup/widget/button.dart';

import '../Services/authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congratulation\n You have Sussefully Logged in",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyButton(
              onTab: ()async{
              await AuthServices().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen()
                ));
            },
             text: "Log Out",)
          ],
        ),
      ),
    );
  }
}