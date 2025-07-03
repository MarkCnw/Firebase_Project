import 'dart:io';
import 'package:crud/realtimedata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController descriptionController = TextEditingController(); // เปลี่ยนชื่อ
final TextEditingController priceController = TextEditingController();       // เปลี่ยนชื่อ
File? _imageFile;

void updateButtomSheet({
  required BuildContext context,
  required String? image,
  required String name,
  required String id,
  required String description, // เปลี่ยนจาก sn เป็น description
  required String price,       // เปลี่ยนจาก address เป็น price
  }){
  // ✅ ใส่ข้อมูลเดิมลงใน TextField
  nameController.text = name;
  descriptionController.text = description; // เปลี่ยนจาก snController
  priceController.text = price;             // เปลี่ยนจาก addressController
  _imageFile = null;
  
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder( // ✅ เพิ่ม StatefulBuilder เพื่อให้ UI อัปเดตได้
        builder: (BuildContext context, StateSetter setState) {
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
                        setState(() { // ✅ อัปเดต UI เมื่อเลือกรูปใหม่
                          _imageFile = File(pickedImage.path);
                        });
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
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(_imageFile!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                            )
                          : image != null && image != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(image, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                                )
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
                    controller: descriptionController, // เปลี่ยนจาก snController
                    decoration: InputDecoration(
                      labelText: "รายละเอียด",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: priceController, // เปลี่ยนจาก addressController
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

                      // ✅ อัปเดตข้อมูลใน Database ให้ตรงกับโครงสร้าง
                      await databaseReference.child(id).update({
                        'name': nameController.text,
                        'Description': descriptionController.text, // เปลี่ยนจาก 'sn'
                        'Price': priceController.text,             // เปลี่ยนจาก 'address'
                        'image': imageUrl ?? '',
                      });

                      // ✅ เคลียร์ Controller หลังอัปเดต
                      nameController.clear();
                      descriptionController.clear();
                      priceController.clear();
                      _imageFile = null;

                      Navigator.pop(context);
                      
                      // แสดงข้อความยืนยันการอัปเดต
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('อัปเดตสินค้าเรียบร้อยแล้ว')),
                      );
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}