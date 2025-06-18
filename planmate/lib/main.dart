import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planmate/Home/presentation/home.dart';
import 'package:planmate/Onboarding/Presentation/onboarding_screen.dart';
import 'package:planmate/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  } 
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // เปลี่ยนจาก AuthService()
      builder: (context, snapshot) {
        // แสดง loading ขณะรอการเชื่อมต่อ
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }
        
        // ถ้า error
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            ),
          );
        }
        
        // ถ้ามี user (login แล้ว) -> ไปหน้า home
        if (snapshot.hasData && snapshot.data != null) {
          print('User logged in: ${snapshot.data!.uid}'); // debug
          return HomePage();
        }
        
        // ถ้าไม่มี user (ยังไม่ login) -> ไปหน้า onboarding
        print('No user found, showing onboarding'); // debug
        return const OnboardingScreen();
      },
    );
  }
}