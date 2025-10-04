import 'package:employee_service_system/app/providers/adminProviders/admin_auth_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/presentation/resources/apptext_field.dart';
import 'package:employee_service_system/routing/routes.dart';

class SigninForm extends ConsumerStatefulWidget {
  const SigninForm({super.key});

  @override
  ConsumerState<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends ConsumerState<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isVisible = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> onSignin(
      TextEditingController email,
      TextEditingController password,
    ) async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        try {
          await ref
              .read(adminAuthProvider.notifier)
              .signInAdmin(email.text, password.text);
          await PrefService.saveToken(ref);
          if (context.mounted) {
            Navigator.pushNamed(context, Routes.idCheck);
          }
        } catch (e) {
          final errorMsg = e.toString().split(":").last.trim();
          print(e);
          await PrefService.deleteToken();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMsg),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    return Container(
      height: 600.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              ApptextField(
                controller: emailController,
                label: S.of(context).enterYourEmail,
                keyboardType: TextInputType.emailAddress,
                prefix: const Icon(Icons.email_outlined),
                isObscureText: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).emailRequired;
                  }
                  // simple email regex
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return S.of(context).invalidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              ApptextField(
                controller: passwordController,
                label: S.of(context).enterYourPassword,
                prefix: const Icon(Icons.lock_outline),
                isObscureText: true,
                obscureText: _isVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).passwordRequired;
                  }
                  // if (value.length < 6) {
                  //   return 'Password must be at least 6 characters';
                  // }
                  // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  //   return 'Password must contain at least one uppercase letter';
                  // }
                  // if (!RegExp(r'[0-9]').hasMatch(value)) {
                  //   return 'Password must contain at least one number';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              AppButton(
                onPressed: _isLoading
                    ? () {
                        return;
                      }
                    : () {
                        onSignin(emailController, passwordController);
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        S.of(context).signIn,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
