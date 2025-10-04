import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/auth/signin/widgets/signin_form.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 61.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Reserve enough height so the overlaid form can scroll
                SizedBox(
                  width: double.infinity,
                  height: 700.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200.h,
                  child: Image.asset(
                    'assets/images/form_container.png.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 170.h,
                  left: 0,
                  right: 0,
                  child: const SigninForm(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
