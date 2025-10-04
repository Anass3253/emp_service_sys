import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/employee/profile/widgets/overview_screen.dart';
import 'package:employee_service_system/presentation/employee/profile/widgets/priv_info_screen.dart';

class AboutMeScreen extends ConsumerStatefulWidget {
  const AboutMeScreen({super.key});

  @override
  ConsumerState<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends ConsumerState<AboutMeScreen> {
  @override
  Widget build(BuildContext context) {
    final localeLang = S.of(context);
    final currentEmp = ref.read(empInfoProvider).value;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(localeLang.profile)),
        body: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            children: [
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
                  color: Theme.of(context).colorScheme.secondary
                ),
                tabs:  [
                  Tab(child: Text(localeLang.overviewTitle)),
                  Tab(child: Text(localeLang.privateInformation)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OverviewScreen(user: currentEmp!),
                    PrivInfoScreen(user: currentEmp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
