import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final File?
  initialImage; // แก้ไข: เพิ่มคำอธิบายว่ารูปเริ่มต้นที่ส่งเข้ามา
  final String?
  networkImageUrl; // แก้ไข: เพิ่มคำอธิบายว่าเป็น URL ของรูป (ใช้ใน edit mode)
  final Function(File?)
  onImageChanged; // แก้ไข: เพิ่มคำอธิบายว่าฟังก์ชันนี้จะถูกเรียกเมื่อรูปเปลี่ยน
  final double
  height; // แก้ไข: เพิ่มคำอธิบายว่าความสูงของ container สามารถปรับได้

  const ImagePickerWidget({
    Key? key,
    required this.initialImage,
    required this.networkImageUrl,
    required this.onImageChanged,
    this.height = 200, // ปรับค่า default ของ height
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final _imagePicker =
      ImagePicker(); // แก้ไข: เพิ่มคำอธิบายว่าใช้ library image_picker
  File? _selectedImage; // แก้ไข: เปลี่ยนชื่อให้สื่อความหมายชัดเจน
  String? _error; // แก้ไข: เพิ่มตัวแปรสำหรับ error handling

  @override
  void initState() {
    super.initState();
    _selectedImage = widget
        .initialImage; // แก้ไข: ตรวจสอบ initialImage ว่าถูกกำหนดหรือยัง
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(
            image.path,
          ); // แก้ไข: อัพเดต _selectedImage
        });
        widget.onImageChanged(
          _selectedImage,
        ); // แก้ไข: เรียก callback เมื่อรูปเปลี่ยน
      }
    } catch (e) {
      _showError('Error picking image: $e'); // แก้ไข: เพิ่ม error handling
    }
  }

  void _showError(String message) {
    if (!mounted) return; // แก้ไข: ตรวจสอบว่า Widget ยังอยู่ใน Tree ก่อน
    setState(() {
      _error = message; // แก้ไข: อัพเดต error message
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ), // แก้ไข: เพิ่ม SnackBar สำหรับแสดง error
    );
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(
            image.path,
          ); // แก้ไข: อัพเดต _selectedImage
        });
        widget.onImageChanged(
          _selectedImage,
        ); // แก้ไข: เรียก callback เมื่อรูปเปลี่ยน
      }
    } catch (e) {
      _showError('Error taking photo: $e'); // แก้ไข: เพิ่ม error handling
    }
  }

  Widget _buildImageContent() {
    if (_selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          8,
        ), // แก้ไข: เพิ่ม borderRadius ให้รูป
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    if (widget.networkImageUrl != null &&
        widget.networkImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          8,
        ), // แก้ไข: เพิ่ม borderRadius ให้รูป
        child: Image.network(
          widget.networkImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            ); // แก้ไข: เพิ่ม loading indicator
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildImagePlaceholder(); // แก้ไข: ใช้ placeholder เมื่อโหลดรูปผิดพลาด
          },
        ),
      );
    }

    return _buildImagePlaceholder(); // แก้ไข: แสดง placeholder เมื่อไม่มีรูป
  }

  Widget _buildImagePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate,
            size: 48,
            color: Colors.grey[400], // แก้ไข: เพิ่มสีให้ placeholder icon
          ),
          const SizedBox(height: 8),
          Text(
            'Tap to add image',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ), // แก้ไข: เพิ่มสีและขนาดข้อความ
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Image',
          style: Theme.of(
            context,
          ).textTheme.titleMedium, // แก้ไข: ใช้ Theme เพื่อ styling
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage, // แก้ไข: เชื่อมต่อ action เมื่อคลิก
          child: Container(
            height: widget.height, // แก้ไข: ใช้ parameter height
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(
                8,
              ), // แก้ไข: เพิ่ม borderRadius ให้ container
              color: Colors.grey[50],
            ),
            child: _buildImageContent(), // แก้ไข: แสดงรูปหรือ placeholder
          ),
        ),
      ],
    );
  }
}
