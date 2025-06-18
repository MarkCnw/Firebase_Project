import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planmate/Auth/presentation/login_screen.dart';
import 'package:planmate/Auth/services/google_service.dart';
import 'package:planmate/Widgets/bunton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Congratulations!\nYou have successfully logged in",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // แสดงรูปโปรไฟล์ (ถ้ามี)
              if (user?.photoURL != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),

              const SizedBox(height: 10),

              // แสดงอีเมล (ถ้ามี)
              if (user?.email != null)
                Text(
                  user!.email!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

              // แสดงชื่อผู้ใช้ (ถ้ามี)
              if (user?.displayName != null)
                Text(
                  user!.displayName!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

              const SizedBox(height: 30),

              // ปุ่ม Log Out
              MyButton(
                onTab: () async {
                  await FirebaseServices().googleSignOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                text: "Log Out",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
