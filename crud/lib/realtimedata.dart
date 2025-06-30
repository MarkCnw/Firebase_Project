import 'package:crud/createbutton.dart';
import 'package:crud/update_bottom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealTimeCrudeDatabase extends StatefulWidget {
  const RealTimeCrudeDatabase({super.key});

  @override
  State<RealTimeCrudeDatabase> createState() =>
      _RealTimeCrudeDatabaseState();
}

final databaseReference = FirebaseDatabase.instance.ref("StoreData");

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
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (context, snapshot, index, animation) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      snapshot.child("name").value.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.child("address").value.toString(),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text(snapshot.child("sn").value.toString()),
                    ),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              updateButtomSheet(
                                context,
                                snapshot.child("name").value.toString(),
                                snapshot.child("id").value.toString(),
                                snapshot.child("sn").value.toString(),
                                snapshot.child("address").value.toString(),
                              );
                            },
                            leading: Icon(Icons.edit),
                            title: Text("Edit"),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              databaseReference
                                  .child(
                                    snapshot.child('id').value.toString(),
                                  )
                                  .remove();
                            },
                            leading: Icon(Icons.delete),
                            title: Text("Edit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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
