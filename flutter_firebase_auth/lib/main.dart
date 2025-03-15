import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Login%20SignUp/Screen/login.dart';

import 'Login SignUp/Screen/home_screen.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
          if (snapshot.hasData) {
            return HomeScreen();
          }else{
            return LoginScreen();
          }
         }
      ) ,
    );
  }
}
