import 'package:flutter/material.dart';
import 'package:pets_app/styles/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Icon? prefixIcon;
  final bool isLoading;
  final double width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.borderRadius = 8.0,
    required this.onPressed,
    this.padding,
    this.prefixIcon,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isLoading ? backgroundColor.withOpacity(0.5) : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) prefixIcon!,
                  SizedBox(width: prefixIcon != null ? 8.0 : 0),
                  Text(
                    text,
                    style: AppTextStyles.medium(color: textColor),
                  ),
                ],
              ),
      ),
    );
  }
}
