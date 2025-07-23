// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProductFormFields extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController price;

  const ProductFormFields({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title Field
        TextFormField(
          controller: title,
          decoration: const InputDecoration(
            labelText: 'Product Title',
            hintText: 'Enter product name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a product title';
            }
            if (value.trim().length < 2) {
              return 'Title must be at least 2 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Price Field
        TextFormField(
          controller: price,
          decoration: const InputDecoration(
            labelText: 'Price (\$)',
            hintText: 'Enter price',
            border: OutlineInputBorder(),
            prefixText: '\$ ',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a price';
            }
            final price = double.tryParse(value.trim());
            if (price == null) {
              return 'Please enter a valid number';
            }
            if (price < 0) {
              return 'Price cannot be negative';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
