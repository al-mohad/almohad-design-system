import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final EdgeInsets padding;
  final int? maxLength;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.obscuringCharacter = '●', // Default: Big dot
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.validator,
    this.onChanged,
    this.textStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.maxLength,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderColor = borderColor ?? theme.colorScheme.primary;
    final defaultFocusedBorderColor =
        focusedBorderColor ?? theme.colorScheme.secondary;
    final defaultTextStyle = textStyle ?? theme.textTheme.bodyMedium;

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        onChanged: onChanged,
        validator: validator,
        style: defaultTextStyle,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: defaultBorderColor)
                  : null,
          suffixIcon:
              suffixIcon != null
                  ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: Icon(suffixIcon, color: defaultBorderColor),
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: defaultBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: defaultFocusedBorderColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
