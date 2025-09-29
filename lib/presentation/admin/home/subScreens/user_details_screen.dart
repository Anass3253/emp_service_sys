import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:employee_service_system/presentation/employee/profile/widgets/overview_screen.dart';
import 'package:employee_service_system/presentation/employee/profile/widgets/priv_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/admin/home/widgets/modify_user_sheet.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/presentation/resources/gradient_appbar.dart';
import 'package:employee_service_system/presentation/resources/theme_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.user});
  final Employee user;
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  void _submitEdit() async {
    showModalBottomSheet(
      showDragHandle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      isScrollControlled: true,
      context: context,
      builder: (context) => const ModifyUserSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: GradientAppbar(
          title: 'Employee Details',
          gradient: Theme.of(
            context,
          ).extension<GradientTheme>()!.appBarGradient,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/defaultProfilePic.png',
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            widget.user.workEmail,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              const Divider(thickness: 1),
              TabBar(
                indicatorColor: Colors.blue,
                dividerColor: Colors.transparent,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsetsGeometry.only(bottom: 5.h),
                labelColor: Colors.white,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: Theme.of(
                    context,
                  ).extension<BackgroundTheme>()!.scaffoldGradient,
                ),
                tabs: const [
                  Tab(child: Text('Overview')),
                  Tab(child: Text('Private Information')),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OverviewScreen(user: widget.user),
                    PrivInfoScreen(user: widget.user),
                  ],
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: 2.h, right: 2.w, left: 2.w),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              onPressed: _submitEdit,
              child: Text(
                'Edit Employee',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
