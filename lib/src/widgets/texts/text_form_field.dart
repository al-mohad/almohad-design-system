import 'package:flutter/material.dart';

/// Enum representing different types of text fields.
enum CustomTextFieldType {
  text,
  multiText,
  password,
  email,
  phone,
  number,
  decimal,
  url,
  search,
  date,
  time,
}

/// A customizable text field widget supporting multiple input types.
///
/// This widget adapts based on the `fieldType` to provide tailored input behavior.
/// It supports standard text input, passwords with toggle visibility, multi-line
/// text, numbers, email, URLs, search, and even date/time pickers.
///
/// The `CustomTextFieldType` enum determines the input type:
/// - `text`: Standard single-line text input.
/// - `multiText`: Multi-line text field.
/// - `password`: Secure password input with toggle visibility.
/// - `email`: Email input with appropriate keyboard type.
/// - `phone`: Numeric phone input.
/// - `number`: Integer-only input.
/// - `decimal`: Decimal number input.
/// - `url`: URL input with the correct keyboard type.
/// - `search`: Text input with a search icon and submission action.
/// - `date`: Opens a date picker on tap.
/// - `time`: Opens a time picker on tap.
class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final CustomTextFieldType fieldType;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSearchSubmitted;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final EdgeInsets padding;
  final int? maxLength;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.fieldType = CustomTextFieldType.text,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.validator,
    this.onChanged,
    this.onSearchSubmitted,
    this.textStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.maxLength,
    this.maxLines,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final bool _isPasswordVisible = false;

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case CustomTextFieldType.multiText:
        return TextInputType.multiline;
      case CustomTextFieldType.password:
        return TextInputType.text;
      case CustomTextFieldType.email:
        return TextInputType.emailAddress;
      case CustomTextFieldType.phone:
        return TextInputType.phone;
      case CustomTextFieldType.number:
        return TextInputType.number;
      case CustomTextFieldType.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case CustomTextFieldType.url:
        return TextInputType.url;
      case CustomTextFieldType.search:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  void _handleTap(BuildContext context) async {
    if (widget.fieldType == CustomTextFieldType.date) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (!context.mounted) return; // Proper way to check context validity

      if (pickedDate != null && widget.controller != null) {
        widget.controller!.text = pickedDate.toLocal().toString().split(' ')[0];
      }
    } else if (widget.fieldType == CustomTextFieldType.time) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (!context.mounted) return; // Proper check for context validity

      if (pickedTime != null && widget.controller != null) {
        widget.controller!.text = pickedTime.format(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderColor = widget.borderColor ?? theme.colorScheme.primary;
    final defaultFocusedBorderColor =
        widget.focusedBorderColor ?? theme.colorScheme.secondary;
    final defaultTextStyle = widget.textStyle ?? theme.textTheme.bodyMedium;

    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: _getKeyboardType(),
        obscureText:
            widget.fieldType == CustomTextFieldType.password &&
            !_isPasswordVisible,
        obscuringCharacter: widget.obscuringCharacter,
        onChanged: widget.onChanged,
        validator: widget.validator,
        maxLength: widget.maxLength,
        maxLines: widget.fieldType == CustomTextFieldType.multiText ? null : 1,
        readOnly:
            widget.fieldType == CustomTextFieldType.date ||
            widget.fieldType == CustomTextFieldType.time,
        onTap:
            (widget.fieldType == CustomTextFieldType.date ||
                    widget.fieldType == CustomTextFieldType.time)
                ? () => _handleTap(context)
                : null,
        onFieldSubmitted:
            widget.fieldType == CustomTextFieldType.search
                ? widget.onSearchSubmitted
                : null,
        style: defaultTextStyle,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              widget.suffixIcon != null
                  ? GestureDetector(
                    onTap: widget.onSuffixIconTap,
                    child: widget.suffixIcon,
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: defaultBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
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
