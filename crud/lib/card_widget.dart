import 'package:crud/realtimedata.dart';
import 'package:crud/update_bottom.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: item['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
                SizedBox(height: 8),
                Text(
                  item['name'] ?? 'NoName',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(item['Description'] ?? 'NoDescription'),
                Text(item['Price'] ?? 'NoPrice'),
              ],
            ),
          ),

          // แก้ไขการส่งข้อมูลให้ตรงกับโครงสร้างฐานข้อมูล
          Positioned(
            top: 120,
            right: 4,
            child: PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit"),
                    onTap: () {
                      Navigator.pop(context);
                      // ✅ แก้ไขการส่งข้อมูลให้ตรงกับโครงสร้างฐานข้อมูล
                      updateButtomSheet(
                        context: context,
                        image: item['image'],
                        name: item['name'] ?? '',
                        id: item['id'] ?? '',
                        description: item['Description'] ?? '', // เปลี่ยนจาก sn เป็น description
                        price: item['Price'] ?? '',           // เปลี่ยนจาก address เป็น price
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete"),
                    onTap: () {
                      Navigator.pop(context);
                      databaseReference.child(item['id']).remove();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}