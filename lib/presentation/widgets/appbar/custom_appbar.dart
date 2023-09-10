import 'package:flutter/material.dart';
import 'package:pets_app/constants/color_constants.dart';

import '../../../styles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final bool centerTitle;

  const CustomAppBar(
      {super.key, required this.title, this.centerTitle = true, this.subTitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.15),
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        centerTitle: centerTitle,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.medium(),
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: AppTextStyles.light(
                    color: ColorConstants.primaryColor, fontSize: 12),
              ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
