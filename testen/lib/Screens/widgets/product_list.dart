import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {  // ย้าย ListView ไปไว้ที่นี่
  final List<Product> products;
  final VoidCallback onReload;
  final Function(Product) onEdit;
  final Function(Product) onDelete;

  const ProductList({
    Key? key,
    required this.products,
    required this.onReload,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🟡 ถ้ายังไม่มีสินค้า
    if (products.isEmpty) {
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

    // ✅ ถ้ามีสินค้า
    return RefreshIndicator(
      onRefresh: () async => onReload(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onEdit: () => onEdit(product),
            onDelete: () => onDelete(product),
          );
        },
      ),
    );
  }
}
