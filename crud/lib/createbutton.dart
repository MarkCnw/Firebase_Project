import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:crud/realtimedata.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController addressController = TextEditingController();
File? _imageFile;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Create Your Item",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    _imageFile = File(pickedImage.path);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 40, color: Colors.grey),
                            Text("แตะเพื่อเลือกรูปสินค้า"),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: snController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final id = DateTime.now().microsecondsSinceEpoch.toString();
                  String? imageUrl;

                  if (_imageFile != null) {
                    final ref = FirebaseStorage.instance.ref().child('product_images/$id.jpg');
                    await ref.putFile(_imageFile!);
                    imageUrl = await ref.getDownloadURL();
                  }

                  await databaseReference.child(id).set({
                    'id': id,
                    'name': nameController.text,
                    'Description': snController.text,
                    'Price': addressController.text,
                    'image': imageUrl ?? '',
                  });

                  nameController.clear();
                  snController.clear();
                  addressController.clear();
                  _imageFile = null;

                  Navigator.pop(context);
                },
                child: Text("เพิ่มสินค้า"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
