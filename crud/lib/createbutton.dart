import 'package:crud/realtimedata.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController addressController = TextEditingController();

// ฟังก์ชันสำหรับเพิ่มข้อมูลใหม่
void createButtomSheet(BuildContext context) {
  // ล้างข้อมูลเก่าออกก่อน
  nameController.clear();
  snController.clear();
  addressController.clear();
  
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context,
    builder: (BuildContext context) {
      return _buildBottomSheet(context, isEdit: false);
    },
  );
}

// ฟังก์ชันสำหรับแก้ไขข้อมูล
void editBottomSheet(BuildContext context, Map<dynamic, dynamic> item) {
  // ใส่ข้อมูลเก่าลงใน TextController
  nameController.text = item['name']?.toString() ?? '';
  snController.text = item['sn']?.toString() ?? '';
  addressController.text = item['address']?.toString() ?? '';
  
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context,
    builder: (BuildContext context) {
      return _buildBottomSheet(context, isEdit: true, itemId: item['id']?.toString());
    },
  );
}

// Widget ส่วนกลางสำหรับ Bottom Sheet
Widget _buildBottomSheet(BuildContext context, {required bool isEdit, String? itemId}) {
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
              isEdit ? "แก้ไขข้อมูล" : "เพิ่มข้อมูลใหม่",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "ชื่อ",
              hintText: "เช่น สมชาย",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: snController,
            decoration: InputDecoration(
              labelText: "เลขที่",
              hintText: "เช่น 1",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.numbers),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: "ที่อยู่",
              hintText: "เช่น กรุงเทพฯ",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            maxLines: 2,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text("ยกเลิก"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _saveData(context, isEdit: isEdit, itemId: itemId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEdit ? Colors.orange : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(isEdit ? "บันทึก" : "เพิ่ม"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ฟังก์ชันบันทึกข้อมูล (ทั้งเพิ่มและแก้ไข)
Future<void> _saveData(BuildContext context, {required bool isEdit, String? itemId}) async {
  // ตรวจสอบว่ากรอกข้อมูลครบหรือไม่
  if (nameController.text.trim().isEmpty || 
      snController.text.trim().isEmpty || 
      addressController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("กรุณากรอกข้อมูลให้ครบถ้วน"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    if (isEdit && itemId != null) {
      // แก้ไขข้อมูล
      await databaseReference.child(itemId).update({
        'name': nameController.text.trim(),
        'sn': snController.text.trim(),
        'address': addressController.text.trim(),
        'updatedAt': DateTime.now().toIso8601String(),
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("แก้ไขข้อมูลสำเร็จ!"),
          backgroundColor: Colors.green,
        ),
      );
      
    } else {
      // เพิ่มข้อมูลใหม่
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      
      await databaseReference.child(id).set({
        'name': nameController.text.trim(),
        'sn': snController.text.trim(),
        'address': addressController.text.trim(),
        'id': id,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("เพิ่มข้อมูลสำเร็จ!"),
          backgroundColor: Colors.green,
        ),
      );
    }

    // ล้างข้อมูลและปิด Modal
    nameController.clear();
    snController.clear();
    addressController.clear();
    Navigator.pop(context);
    
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("เกิดข้อผิดพลาด: $error"),
        backgroundColor: Colors.red,
      ),
    );
  }
}