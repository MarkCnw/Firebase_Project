import 'package:flutter/material.dart';
import 'package:testen/Services/firebase_product_service.dart';
import 'package:testen/Screens/widgets/confirm_dialog.dart';


import 'package:testen/Screens/widgets/product_empty_view.dart';
import 'package:testen/Screens/widgets/product_error_view.dart';
import 'package:testen/Screens/widgets/product_list.dart';
import 'package:testen/features/crud/create_product_dialog.dart';
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
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }

  void _showCreateDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CreatebutttonWidget(
        onProductCreated: () {
          Navigator.pop(context);
          // Products will be updated automatically via stream
        },
      ),
    );
  }

  void _showEditDialog(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CreatebutttonWidget(
        product: product,
        onProductCreated: () {
          Navigator.pop(context);
          // Products will be updated automatically via stream
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

    if (confirmed == true) {
      await _deleteProduct(product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Product Manager",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadProducts,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ย้ายส่วนแสดง "product_error_view.dart"
    if (_error != null) {
      return ProductErrorView(error: _error!, onRetry: _loadProducts);
    }

    // ย้ายส่วนแสดง "product_empty_view.dart"
    if (_products.isEmpty) {
      return ProductEmptyView(
        text: 'No product',
        description: 'Add your First product using the + button',
      );
    }

    return ProductList(
      products: _products,
      onReload: _loadProducts,
      onEdit: _showEditDialog,
      onDelete: _showDeleteConfirmation,
    );
  }
}
