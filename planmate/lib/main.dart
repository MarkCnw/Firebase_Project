import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:planmate/Auth/services/auth_service.dart';
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
      home: AuthWrapper(), // ใช้ AuthWrapper แทน OnboardingScreen
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // แสดง loading ขณะรอ auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              )
            ),
          );
        }
        
        // ถ้า login แล้ว -> ไปหน้าหลัก (ต้องสร้างหน้า HomePage)
        if (snapshot.hasData) {
          return HomePage(); // TODO: สร้างหน้า HomePage
        }
        
        // ถ้ายังไม่ login -> แสดง onboarding
        return const OnboardingScreen();
      },
    );
  }
}

// TODO: สร้างหน้า HomePage (ตัวอย่าง)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlanMate'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              // AuthWrapper จะ handle การ redirect กลับไป login อัตโนมัติ
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to PlanMate!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}