import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApptextField extends StatelessWidget {
  const ApptextField({
    super.key,
    required this.controller,
    required this.label,
    required this.isObscureText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefix,
    this.onToggleVisibility,
    this.inputDecoration,
  });
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isObscureText;
  final String? Function(String? value)? validator;
  final Widget? prefix;
  final VoidCallback? onToggleVisibility;
  final InputDecoration? inputDecoration;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: inputDecoration ?? InputDecoration(
        focusColor: Theme.of(context).colorScheme.onPrimary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        prefixIcon: prefix,
        suffixIcon: isObscureText
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}
