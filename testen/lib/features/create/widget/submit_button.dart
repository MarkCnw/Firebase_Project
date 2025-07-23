import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isEditMode;
  final bool isLoading;
  final VoidCallback onPressed;

  const SubmitButton({
    Key? key,
    required this.isEditMode,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(isEditMode ? 'Update Product' : 'Create Product'),
    );
  }
}
