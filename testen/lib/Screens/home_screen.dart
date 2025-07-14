import 'package:flutter/material.dart';
import 'package:testen/Widgets/product_error_view.dart';

import 'package:testen/Widgets/product_list.dart';
import '../models/product_model.dart';
import '../services/firebase_product_service.dart';
import '../widgets/createbuttton_widget.dart';
import '../widgets/confirm_dialog.dart';

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

    if (_error != null) {
      // ย้ายส่วนแสดง "product_error_view.dart"
      return ProductErrorView(error: _error!, onRetry: _loadProducts);
    }

    if (_products.isEmpty) {
      // ย้ายส่วนแสดง "product_empty_view.dart"
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first product using the + button',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
