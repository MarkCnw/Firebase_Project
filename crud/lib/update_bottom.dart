import 'dart:io';
import 'package:crud/realtimedata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController addressController = TextEditingController();
File? _imageFile;

void updateButtomSheet({
  required BuildContext context,
  required String? image,
  required String name,
  required String id,
  required String sn,
  required String address,
  }){
    nameController.text = name;
  snController.text = sn;
  addressController.text = address;
  _imageFile = null;
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
                  "Update Your Item",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // รูปภาพปัจจุบันหรือใหม่
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
                      : image != null && image != ''
                          ? Image.network(image, fit: BoxFit.cover)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 40, color: Colors.grey),
                                Text("แตะเพื่อเลือกรูปใหม่"),
                              ],
                            ),
                ),
              ),

              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "ชื่อสินค้า",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                controller: snController,
                decoration: InputDecoration(
                  labelText: "รายละเอียด",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "ราคา",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  String? imageUrl = image;

                  // ถ้าเลือกรูปใหม่ → อัปโหลดทับของเดิม
                  if (_imageFile != null) {
                    final ref = FirebaseStorage.instance.ref().child('product_images/$id.jpg');
                    await ref.putFile(_imageFile!);
                    imageUrl = await ref.getDownloadURL();
                  }

                  // อัปเดตข้อมูลใน Database
                  await databaseReference.child(id).update({
                    'name': nameController.text,
                    'sn': snController.text,
                    'address': addressController.text,
                    'image': imageUrl ?? '',
                  });

                  nameController.clear();
                  snController.clear();
                  addressController.clear();
                  _imageFile = null;

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
