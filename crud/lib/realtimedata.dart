import 'package:crud/card_widget.dart';
import 'package:crud/createbutton.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class RealTimeCrudeDatabase extends StatefulWidget {
  const RealTimeCrudeDatabase({super.key});

  @override
  State<RealTimeCrudeDatabase> createState() =>
      _RealTimeCrudeDatabaseState();
}

final databaseReference = FirebaseDatabase.instance.ref("Database");

class _RealTimeCrudeDatabaseState extends State<RealTimeCrudeDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("CRUD"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data!.snapshot.value != null) {
                  Map data = snapshot.data!.snapshot.value as Map;
                  List items = data.values.toList();
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(items.length, (index) {
                      var item = items[index];
                      return ProductCard(item: item);
                    }),
                  );
                } else {
                  return Center(
                    child: Text("No data found"),
                  );
                }
              },
            ),
            
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createButtomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
