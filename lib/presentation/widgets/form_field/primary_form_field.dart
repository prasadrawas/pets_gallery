import 'package:flutter/material.dart';
import 'package:pets_app/constants/color_constants.dart';
import 'package:pets_app/styles/text_styles.dart';

class PrimaryFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool isPassword;
  final Icon? prefixIcon;
  final double borderRadius;
  final bool filled;
  final bool enabled;
  final String? Function(String?)? validatorFunction;
  final EdgeInsetsGeometry margin;
  final bool obscureTextDefault;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? maxLength;

  const PrimaryFormField({
    super.key,
    required this.hint,
    this.label,
    this.isPassword = false,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.filled = false,
    this.validatorFunction,
    this.enabled = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
    this.obscureTextDefault = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    this.contentPadding,
    this.onTap,
    this.width,
    this.maxLines,
    this.maxLength,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PrimaryFormFieldState createState() => _PrimaryFormFieldState();
}

class _PrimaryFormFieldState extends State<PrimaryFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureTextDefault;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? double.infinity,
        margin: widget.margin,
        child: TextFormField(
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          style: AppTextStyles.regular(),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.regular(),
            labelText: widget.label,
            labelStyle: AppTextStyles.regular(),
            prefixIcon: widget.prefixIcon,
            prefixIconColor: Colors.black87,
            counterText: '',
            filled: widget.filled,
            fillColor: Colors.grey[200],
            focusColor: ColorConstants.primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstants.primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            // Set the border color to a faint color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(17.0),
          ),
          obscureText: widget.isPassword && _obscureText,
          validator: widget.validatorFunction,
        ),
      ),
    );
  }
}
