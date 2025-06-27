import 'package:crud/createbutton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealTimeCrudeDatabase extends StatefulWidget {
  const RealTimeCrudeDatabase({super.key});

  @override
  State<RealTimeCrudeDatabase> createState() =>
      _RealTimeCrudeDatabaseState();
}

final DatabaseReference = FirebaseDatabase.instance.ref();

class _RealTimeCrudeDatabaseState extends State<RealTimeCrudeDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("CRUD"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createButtomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
