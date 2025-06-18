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
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Debug logs
        print('AuthWrapper - Connection state: ${snapshot.connectionState}');
        print('AuthWrapper - Has data: ${snapshot.hasData}');
        print('AuthWrapper - User: ${snapshot.data?.uid}');
        
        // ถ้า error
        if (snapshot.hasError) {
          print('AuthWrapper - Error: ${snapshot.error}');
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            ),
          );
        }
        
        // ✅ เช็คการมี user ก่อน - ไม่ว่า connection state จะเป็นอะไร
        if (snapshot.hasData && snapshot.data != null) {
          print('AuthWrapper - User logged in, showing HomePage: ${snapshot.data!.uid}');
          return HomePage();
        }
        
        // ถ้า connection กำลัง waiting และยังไม่มี data เลย
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          print('AuthWrapper - Showing loading');
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }
        
        // ถ้าไม่มี user (ยังไม่ login)
        print('AuthWrapper - No user found, showing onboarding');
        return const OnboardingScreen();
      },
    );
  }
}