import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Color color; // warna utama saat dipilih
  final Color borderColor; // warna border default
  final Color textColor; // warna teks dinamis
  final double width;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.isSelected = false,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: borderColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 6),
              )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              text.toLowerCase() == 'ya' ? Icons.check : Icons.close,
              color: textColor,
              size: 22,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
