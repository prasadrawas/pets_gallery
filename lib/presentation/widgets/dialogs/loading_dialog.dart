import 'package:flutter/material.dart';
import 'package:pets_app/styles/text_styles.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const CircularProgressIndicator(strokeWidth: 1),
          const SizedBox(width: 16),
          Text(
            message,
            style: AppTextStyles.regular(),
          ),
        ],
      ),
    );
  }
}
