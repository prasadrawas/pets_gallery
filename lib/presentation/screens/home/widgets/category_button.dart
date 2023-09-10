import 'package:flutter/material.dart';
import 'package:pets_app/styles/text_styles.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.onPressed,
    required this.selected,
  });

  final String selected;
  final String category;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          return selected == category ? 1.0 : 0.0;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return selected == category ? Colors.blue : Colors.grey[200]!;
        }),
      ),
      onPressed: () {
        onPressed(category);
      },
      child: Text(
        category,
        style: AppTextStyles.regular(
            color: selected == category ? Colors.white : Colors.black),
      ),
    );
  }
}
