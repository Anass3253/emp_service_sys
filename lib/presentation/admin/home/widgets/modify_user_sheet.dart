import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/presentation/resources/apptext_field.dart';

class ModifyUserSheet extends StatefulWidget {
  const ModifyUserSheet({super.key});

  @override
  State<ModifyUserSheet> createState() => _ModifyUserSheetState();
}

class _ModifyUserSheetState extends State<ModifyUserSheet> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "username": _usernameController.text,
        "email": _emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        height: double.infinity.h,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ApptextField(
                  controller: _usernameController,
                  label: 'Username',
                  isObscureText: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    } else if (value.trim().length < 3) {
                      return 'Username must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),

                ApptextField(
                  controller: _emailController,
                  label: 'Email',
                  isObscureText: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    // simple email regex
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                AppButton(
                  onPressed: _submit,
                  child: Text(
                    'Edit Employee',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
