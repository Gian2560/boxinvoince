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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? ColorsConfig.buttonDisabled
            : backgroundColor,
        foregroundColor: isDisabled ? ColorsConfig.buttonDisabled : textColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: ColorsConfig.buttonLoadingIndicator,
            )
          : Text(text, style: TextStyle(fontSize: 16, color: textColor)),
    );
  }
}
