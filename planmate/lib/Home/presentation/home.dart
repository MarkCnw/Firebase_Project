import 'package:flutter/material.dart';
import 'package:planmate/Auth/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('HomePage - Building HomePage');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlanMate'),
        actions: [
          IconButton(
            onPressed: () async {
              print('HomePage - Sign out pressed');
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