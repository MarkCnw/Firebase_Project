import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color? confirmColor;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: confirmColor ?? Colors.red,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

// Alternative with custom styling
class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color? confirmColor;
  final IconData? icon;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: confirmColor ?? Colors.red,
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
          ),
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor ?? Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

// Usage examples:
/*
// Basic confirm dialog
final result = await showDialog<bool>(
  context: context,
  builder: (context) => ConfirmDialog(
    title: 'Delete Product',
    content: 'Are you sure you want to delete this product?',
    confirmText: 'Delete',
    cancelText: 'Cancel',
  ),
);

// Custom styled confirm dialog
final result = await showDialog<bool>(
  context: context,
  builder: (context) => CustomConfirmDialog(
    title: 'Delete Product',
    content: 'This action cannot be undone.',
    confirmText: 'Delete',
    cancelText: 'Cancel',
    confirmColor: Colors.red,
    icon: Icons.warning,
  ),
);
*/