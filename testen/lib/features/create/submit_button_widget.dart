import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final bool isLoading;
  final String buttonText;
  final VoidCallback? onPressed; // ต้องเป็น VoidCallback

  const SubmitButtonWidget({
    Key? key,
    required this.isLoading,
    required this.buttonText,
    this.onPressed,
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
          : Text(buttonText),
    );
  }
}