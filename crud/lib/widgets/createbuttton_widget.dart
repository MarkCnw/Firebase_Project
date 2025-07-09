import 'dart:io';

import 'package:crud/models/product_model.dart';
import 'package:crud/services/firebase_product_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatebutttonWidget extends StatefulWidget {
  final Product? product;
  final VoidCallback? onProductCreated;

  const CreatebutttonWidget({
    super.key,
    this.product,
    this.onProductCreated,
  });

  @override
  State<CreatebutttonWidget> createState() => _CreatebutttonWidgetState();
}

class _CreatebutttonWidgetState extends State<CreatebutttonWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _productService = FirebaseProductService();
  final _imagePicker = ImagePicker();

  File? _selectedImage;
  bool _isLoading = false;
  String? _error;

  bool get _isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _titleController.text = widget.product!.title;
      _priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
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
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showError('Error picking image: $e');
    }
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
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showError('Error taking photo: $e');
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose From Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
            if (_selectedImage != null ||
                (_isEditMode && widget.product!.imageUrl.isNotEmpty))
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove Image'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedImage = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    setState(() {
      _error = message;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final title = _titleController.text.trim();
      final price = double.parse(_priceController.text.trim());

      if (_isEditMode) {
        // Edit existing product
        final updatedProduct = widget.product!.copyWith(
          title: title,
          price: price,
        );
        await _productService.updateProduct(
          updatedProduct,
          _selectedImage,
        );
      } else {
        // Create new product
        final newProduct = Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          imageUrl: '', // Will be set by service
          price: price,
        );
        await _productService.createProduct(newProduct, _selectedImage);
      }

      if (mounted) {
        widget.onProductCreated?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? 'Product updated successfully'
                  : 'Product created successfully',
            ),
          ),
        );
      }
    } catch (e) {
      _showError('Error saving product: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
