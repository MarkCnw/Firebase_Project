import 'package:crud/realtimedata.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController addressController = TextEditingController();

void updateButtomSheet(BuildContext context, name, id, sn, address) {
  nameController.text = name;
  snController.text = sn;
  addressController.text = address;
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
                  labelText: "name",
                  hintText: "Eg Elon",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: snController,
                decoration: InputDecoration(
                  labelText: "Sn",
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
                  databaseReference.child(id).update({
                    'name': nameController.text,
                    'sn': snController.text,
                    'address': addressController.text,
                  });

                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
