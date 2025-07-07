import 'package:flutter/material.dart';



import '../widgets/createbuttton_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Create Update Delete"),
      ),
     
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CreatebutttonWidget(),
    );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

