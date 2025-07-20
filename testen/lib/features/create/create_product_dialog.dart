import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testen/Services/firebase_product_service.dart';
import 'package:testen/features/create/image_picker_widget.dart';
import 'package:testen/features/create/product_form_widget.dart';
import 'package:testen/features/create/submit_button_widget.dart';

import 'package:testen/models/product_model.dart';

class CreatebutttonWidget extends StatefulWidget {
  final Product? product; // null = create mode, not null = edit mode
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isEditMode ? 'Edit Product' : 'Create Product',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                ImagePickerWidget(
                  initialImage: _selectedImage,
                  networkImageUrl: _isEditMode
                      ? widget.product?.imageUrl
                      : null,
                  height: 200,
                  onImageChanged: (File? image) {
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                ),

                // Image Section
                const SizedBox(height: 16),

                // Title Field
                ProductFormWidget(
                  titleController: _titleController,
                  priceController: _priceController,
                ),
                const SizedBox(height: 24),

                // Save Button
                SubmitButtonWidget(
                  isLoading: _isLoading,
                  buttonText: _isEditMode
                      ? 'Update Product'
                      : 'Create Product',
                  onPressed: _isLoading
                      ? null
                      : () {
                          _saveProduct(); // เรียก _saveProduct() โดยไม่ใช้ async ใน onPressed
                        },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
