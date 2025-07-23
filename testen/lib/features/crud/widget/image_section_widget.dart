import 'dart:io';

import 'package:flutter/material.dart';

class ImageSectionWidget extends StatelessWidget {
  final File? selectedImage; //ภาพที่ถูกเลือก
  final String? imageUrl; //	ภาพเดิมจาก network (ใช้ใน edit mode)
  final VoidCallback onPickImage; // 	เปิด image picker
  final VoidCallback onRemoveImage; // ลบรูป

  const ImageSectionWidget({
    required this.selectedImage,
    required this.imageUrl,
    required this.onPickImage,
    required this.onRemoveImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Image',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
            ),
            child: _buildImageContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (selectedImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onRemoveImage,
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildImagePlaceholder();
          },
        ),
      );
    }

    return _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 8),
        Text(
          'Tap to add image',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ],
    );
  }
}
