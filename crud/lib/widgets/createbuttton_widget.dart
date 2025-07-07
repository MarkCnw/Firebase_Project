import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';
import '../services/firebase_product_service.dart';

class CreateButton extends StatefulWidget {
  final Product? editProduct;
  const CreateButton({super.key, this.editProduct});

  @override
  State<CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  File? _imageFile;

  final _picker = ImagePicker();
  final _productService = FirebaseProductService();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _imageFile == null) return;

    final product = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      imageUrl: '', // จะใส่หลัง upload
      price: double.parse(_priceController.text.trim()),
    );

    await _productService.createProduct(product, _imageFile);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'เพิ่มสินค้า',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image, size: 40, color: Colors.grey),
                            Text("แตะเพื่อเลือกรูปภาพสินค้า"),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อสินค้า',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'กรุณากรอกชื่อสินค้า' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ราคา',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'กรุณากรอกราคา';
                  final parsed = double.tryParse(val);
                  return (parsed == null || parsed <= 0)
                      ? 'กรุณากรอกราคาที่ถูกต้อง'
                      : null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('บันทึกสินค้า'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
