import 'package:flutter/material.dart';
import 'package:pets_app/styles/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final VoidCallback? onTap;

  CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        text,
        style: AppTextStyles.regular(),
      ),
      onTap: onTap,
    );
  }
}
