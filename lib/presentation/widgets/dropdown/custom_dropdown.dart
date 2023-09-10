import 'package:flutter/material.dart';
import 'package:pets_app/constants/color_constants.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String? labelText;
  final Icon? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const CustomDropDown({
    Key? key,
    this.labelText,
    this.prefixIcon,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: ColorConstants.primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          )),
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
