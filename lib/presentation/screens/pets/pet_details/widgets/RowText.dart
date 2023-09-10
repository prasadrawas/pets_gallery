import 'package:flutter/material.dart';
import 'package:pets_app/styles/text_styles.dart';

class RowText extends StatelessWidget {
  final String label;
  final String? value;
  const RowText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$label: ',
            style: AppTextStyles.medium(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value ?? '',
            style: AppTextStyles.light(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
