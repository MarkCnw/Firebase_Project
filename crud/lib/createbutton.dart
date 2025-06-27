import 'package:crud/realtimedata.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController addressController = TextEditingController();
void createButtomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Create Your Items",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Eg Elon",
              ),
            ),
            TextField(
              controller: snController,
              decoration: InputDecoration(
                labelText: "S n",
                hintText: "Eg 1",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "address",
                hintText: "Eg Us",
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final id = DateTime.now().microsecond.toString();
                databaseReference.child((id).toString()).set({
                  'name': nameController.text.toString(),
                  'sn': snController.text.toString(),
                  'address': addressController.text.toString(),
                  'id':id
                });
              },
              child: Text("Add"),
            ),
          ],
        ),
        )
      );
    },
  );
}
