import 'package:crud/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDeleteConfirmed;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDeleteConfirmed,
  });

  void _confirmDelete(BuildContext context) async {
    final confirm = await showConfirmDialog(context);
    if (confirm) {
      onDeleteConfirmed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("฿ ${product.price.toStringAsFixed(2)}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
      ),
    );
  }
}
