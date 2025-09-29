import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
          ),
          padding: WidgetStatePropertyAll(
            padding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
          ),
          shape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(20.r),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
