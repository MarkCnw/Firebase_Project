import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const AvatarItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: isSelected 
                ? Border.all(color: Colors.white, width: 3)
                : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.chakraPetch(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}