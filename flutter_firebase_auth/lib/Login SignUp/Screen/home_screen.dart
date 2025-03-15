import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Login%20SignUp/Service/authentication.dart';

import '../Widget/button.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Crongratulations\n You have successfully logged in",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            MyButton(
                onTab: ()async {
                  await AuthServicews().sigOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
                text: "Log out",
            )
          ],
        ),
      ),
    );
  }
}