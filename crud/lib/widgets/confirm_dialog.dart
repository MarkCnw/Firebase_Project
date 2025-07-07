import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("ยืนยันการลบสินค้า"),
          content: const Text("คุณต้องการลบสินค้านี้จริงหรือไม่?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("ยกเลิก"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("ลบ", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ) ??
      false;
}
