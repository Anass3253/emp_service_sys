import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/services/mobile_info_service.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/presentation/resources/apptext_field.dart';
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
              duration: const Duration(seconds: 5),
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(width: double.infinity, height: 720.h),
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
                    child: Container(
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
                              label: S.of(context).enterYourId,
                              keyboardType: TextInputType.number,
                              prefix: const Icon(Icons.vpn_key),
                              isObscureText: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return S.of(context).idRequired;
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
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      S.of(context).verify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
