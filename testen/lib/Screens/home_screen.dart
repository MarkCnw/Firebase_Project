import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testen/Services/firebase_product_service.dart';
import 'package:testen/Widgets/confirm_dialog.dart';
import 'package:testen/Widgets/createbuttton_widget.dart';
import 'package:testen/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseProductService _productService = FirebaseProductService();
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    _productService.getProducts().listen(
      (products) {
        if (mounted) {
          setState(() {
            _products = products;
            _isLoading = false;
          });
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _error = error.toString();
            _isLoading = false;
          });
        }
      },
    );
  }

  Future<void> _deleteProduct(String id) async {
    try {
      await _productService.deleteProduct(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error to delete product $e')),
        );
      }
    }
  }

  void _showEditDialog(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CreatebutttonWidget(
        product: product,
        onProductCreated: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmation(Product product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Delete Product',
        content: 'Are you sure you want to delete "${product.title}"?',
        confirmText: 'Delete',
        cancelText: 'Cancel',
      ),
    );
    if (mounted == true) {
      await _deleteProduct(product.id);
    }
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
