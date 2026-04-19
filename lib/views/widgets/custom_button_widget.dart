import 'package:flutter/material.dart';
import '../../config/colors_config.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color backgroundColor;
  final Color textColor;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor = ColorsConfig.buttonPrimary,
    this.textColor = ColorsConfig.buttonTextPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? ColorsConfig.buttonDisabled
              : backgroundColor,
          foregroundColor: isDisabled
              ? ColorsConfig.textSecondary
              : textColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? CircularProgressIndicator(color: ColorsConfig.buttonLoadingIndicator)
            : Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: isDisabled ? ColorsConfig.textSecondary : textColor,
          ),
        ),
      ),
    );
  }
}