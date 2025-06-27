import 'package:crud/createbutton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealTimeCrudeDatabase extends StatefulWidget {
  const RealTimeCrudeDatabase({super.key});

  @override
  State<RealTimeCrudeDatabase> createState() => _RealTimeCrudeDatabaseState();
}

final databaseReference = FirebaseDatabase.instance.ref();

class _RealTimeCrudeDatabaseState extends State<RealTimeCrudeDatabase> {
  List<Map<dynamic, dynamic>> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _listenToDatabase();
  }

  void _listenToDatabase() {
    databaseReference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        List<Map<dynamic, dynamic>> tempList = [];
        data.forEach((key, value) {
          if (value is Map) {
            tempList.add(Map<dynamic, dynamic>.from(value));
          }
        });
        // เรียงตามวันที่สร้าง (ใหม่ล่าสุดก่อน)
        tempList.sort((a, b) {
          String aTime = a['createdAt']?.toString() ?? '';
          String bTime = b['createdAt']?.toString() ?? '';
          return bTime.compareTo(aTime);
        });
        
        setState(() {
          dataList = tempList;
          isLoading = false;
        });
      } else {
        setState(() {
          dataList = [];
          isLoading = false;
        });
      }
    });
  }

  void _deleteItem(String id, String name) async {
    try {
      await databaseReference.child(id).remove();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ลบ '$name' สำเร็จ!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("เกิดข้อผิดพลาดในการลบ: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDialog(Map<dynamic, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Text("ยืนยันการลบ"),
            ],
          ),
          content: Text("คุณต้องการลบ '${item['name']}' หรือไม่?\n\nการกระทำนี้ไม่สามารถยกเลิกได้"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteItem(item['id']?.toString() ?? '', item['name']?.toString() ?? '');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text("ลบ"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "CRUD Application",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _listenToDatabase();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ข้อมูลทั้งหมด",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${dataList.length} รายการ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.data_usage,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          
          // Data List
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text("กำลังโหลดข้อมูล..."),
                      ],
                    ),
                  )
                : dataList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "ไม่มีข้อมูล",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "กดปุ่ม + เพื่อเพิ่มข้อมูลใหม่",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final item = dataList[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    item['sn']?.toString() ?? '?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                item['name']?.toString() ?? 'ไม่มีชื่อ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item['address']?.toString() ?? 'ไม่มีที่อยู่',
                                          style: TextStyle(color: Colors.grey[600]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (item['updatedAt'] != null) ...[
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.edit_note, size: 16, color: Colors.orange),
                                        SizedBox(width: 4),
                                        Text(
                                          "แก้ไขล่าสุด",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // ปุ่มแก้ไข
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.edit, color: Colors.orange),
                                      onPressed: () {
                                        editBottomSheet(context, item);
                                      },
                                      tooltip: "แก้ไข",
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // ปุ่มลบ
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _showDeleteDialog(item);
                                      },
                                      tooltip: "ลบ",
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => createButtomSheet(context),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("เพิ่มข้อมูล"),
      ),
    );
  }
}