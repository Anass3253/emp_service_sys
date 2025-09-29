import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/services/mobile_info_service.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/presentation/resources/apptext_field.dart';
import 'package:employee_service_system/presentation/resources/theme_manager.dart';
import 'package:employee_service_system/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdCheckScreen extends ConsumerStatefulWidget {
  const IdCheckScreen({super.key});

  @override
  ConsumerState<IdCheckScreen> createState() => _IdCheckScreenState();
}

class _IdCheckScreenState extends ConsumerState<IdCheckScreen> {
  TextEditingController idFieldController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    idFieldController.dispose();
    super.dispose();
  }

  void _onIdCheck(String id) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final token = await PrefService.getToken();
        final mobileId = await MobileInfoService.getDeviceId();
        if (token != null) {
          await ref
              .read(empInfoProvider.notifier)
              .idChecker(id, token, mobileId);
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.appInit,
              (route) => false,
            );
          }
        } else {
          throw Exception('No authentication token found');
        }
      } catch (e) {
        final errorMsg = e.toString().split(":").last.trim();
        print(e);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              duration: const Duration(seconds: 10),
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(
            context,
          ).extension<GradientTheme>()!.appBarGradient,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/KBI_logo2.png',
                        ),
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Knowledge',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 26.sp,
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextSpan(
                              text: 'BI',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 26.sp,
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.5.h),
                Container(
                  height: 400.h,
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
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        ApptextField(
                          controller: idFieldController,
                          label: 'Enter your ID',
                          keyboardType: TextInputType.number,
                          prefix: const Icon(Icons.vpn_key),
                          isObscureText: false,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'ID is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        AppButton(
                          onPressed: _isLoading
                              ? () {
                                  return;
                                }
                              : () async {
                                  _onIdCheck(idFieldController.text);
                                },
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Verify',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                        ),
                      ],
                    ),
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
