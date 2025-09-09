import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData buttonIcon;
  final String hintText;
  final Function(String) onSubmitted;
  final Function() onButton;
  final Function() onPrefix;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.buttonIcon,
    required this.onSubmitted,
    required this.onButton,
    required this.onPrefix,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(11),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (prefixIcon != null)
              IconButton(
                icon: Icon(prefixIcon!),
                color: const Color(0xFF8D6E63),
                onPressed: onPrefix,
              ),

            // Message input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F0),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFD7CCC8), width: 1),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  onSubmitted: onSubmitted,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Send button
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF8D6E63),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(buttonIcon, color: Colors.white),
                onPressed: onButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
