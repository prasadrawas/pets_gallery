import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSelectionDialog {
  static List<String> petsCategories = ['Dogs', 'Cats'];

  static Future<String?> showStringListDialog() async {
    String? selectedValue;

    await Get.defaultDialog(
      title: 'Select an Item',
      content: SizedBox(
        width: double.maxFinite,
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: petsCategories.length,
          itemBuilder: (context, index) {
            final item = petsCategories[index];
            return ListTile(
              title: Text(item),
              onTap: () {
                selectedValue = item;
                Get.back(result: selectedValue);
              },
            );
          },
        ),
      ),
    );

    return selectedValue;
  }
}
