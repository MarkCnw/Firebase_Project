import 'package:flutter/material.dart';

import '../Widget/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          children: [
            Text(
              "Crongratulations\n You have successfully logged in",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              myButton(
                onTab: () {
                  
                },
                text: "Log Out",
            ))
          ],
        ),
      ),
    );
  }
}