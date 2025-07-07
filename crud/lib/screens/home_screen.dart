import 'package:flutter/material.dart';
import '../services/firebase_product_service.dart';
import '../models/product_model.dart';
import '../widgets/createbuttton_widget.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _productService = FirebaseProductService();

  void _showCreateForm() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const CreateButton(),
  );
}


  void _showEditForm(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CreateButton(editProduct: product),
    );
  }

  void _deleteProduct(String id) async {
    await _productService.deleteProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Create Update Delete"),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _productService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("ยังไม่มีสินค้า"));
          }

          final products = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onEdit: () => _showEditForm(product),
                onDeleteConfirmed: () => _deleteProduct(product.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
