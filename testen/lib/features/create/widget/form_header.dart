import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final bool onEdit;
  final VoidCallback? onClose; // optional: ปิดแบบกำหนดเอง
  final TextStyle? titleTextStyle; // optional: ปรับ style ได้จากภายนอก

  const FormHeader({
    Key? key,
    required this.onEdit,
    this.onClose,
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          onEdit ? 'Edit Product' : 'Create Product',
          style: titleTextStyle ?? Theme.of(context).textTheme.headlineSmall,
        ),
        IconButton(
          onPressed: onClose ?? () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
