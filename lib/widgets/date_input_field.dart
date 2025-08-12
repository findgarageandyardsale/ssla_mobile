import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DateInputField extends StatelessWidget {
  final String name;
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool isRequired;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? iconColor;
  final double? iconSize;

  const DateInputField({
    super.key,
    required this.name,
    this.label,
    this.hintText,
    this.controller,
    this.onTap,
    this.readOnly = true,
    this.validator,
    this.isRequired = false,
    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.fillColor,
    this.hintColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText ?? 'dd/mm/yyyy',
        hintStyle: TextStyle(color: hintColor ?? Colors.grey[400]),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(color: borderColor ?? Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: enabledBorderColor ?? Colors.green[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: focusedBorderColor ?? Colors.green,
            width: 2,
          ),
        ),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon: Icon(
          Icons.calendar_today,
          color: iconColor ?? Colors.grey[600],
          size: iconSize ?? 20,
        ),
      ),
      validator:
          validator ??
          (isRequired
              ? FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'This field is required',
                ),
              ])
              : null),
    );
  }
}
