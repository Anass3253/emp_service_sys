import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/presentation/employee/home/widgets/dashboard_card.dart';
import 'package:employee_service_system/routing/routes.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final empInfoState = ref.watch(empInfoProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final isShort = screenHeight < 412;
    return Scaffold(
      appBar: AppBar(
        // imagePath: 'assets/images/KBI_logo2.png',
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/KBI_logo2.png'),
              radius: 25,
              backgroundColor: Colors.transparent,
            ),
            Text('Knowledge BI'),
          ],
        ),
      ),
      //
      // GradientAppbar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushReplacementNamed(context, Routes.adminHomeScreen);
      //       },
      //       icon: Icon(Icons.person_2_outlined, size: 35.sp),
      //     ),
      //   ],
      //   imagePath: 'assets/images/KBI_logo2.png',
      //   title: 'Knowledge BI',
      //   gradient: Theme.of(context).extension<GradientTheme>()!.appBarGradient,
      // ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: empInfoState.when(
        data: (currentEmp) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topContainer(context, currentEmp, isShort),
              SizedBox(height: isShort ? 10.h : 20.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isShort ? 6.h : 10.h,
                  horizontal: 10.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Dashboard:',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isShort ? 16.sp : 18.sp,
                      ),
                    ),
                    SizedBox(height: isShort ? 6.h : 10.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dashboard().length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isShort ? 3 : 2,
                        childAspectRatio: isShort ? 1.5 : 1.1,
                        mainAxisSpacing: isShort ? 8 : 10,
                        crossAxisSpacing: isShort ? 8 : 10,
                      ),
                      itemBuilder: (context, index) => _dashboard()[index],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16.h),
              Text(
                'Loading your profile...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
              SizedBox(height: 16.h),
              Text(
                'Error loading profile',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                'Please try again later',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _topContainer(BuildContext context, Employee currentEmp, bool isShort) {
  return Container(
    height: (isShort ? 180.h : 230.h),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50.r),
        bottomRight: Radius.circular(50.r),
      ),
      color: Colors.transparent,
    ),
    child: Padding(
      padding: EdgeInsets.all(isShort ? 6.0.w : 8.0.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: (isShort ? 28.r : 35.r),
            backgroundImage: const AssetImage(
              'assets/images/defaultProfilePic.png',
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, ${currentEmp.name}',
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: isShort ? 18.sp : 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  currentEmp.workEmail,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: isShort ? 10.sp : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget> _dashboard() {
  return [
    const DashboardCard(
      icon: Icons.event_available_outlined,
      title: 'Attendance',
      route: Routes.attendanceScreen,
    ),
    const DashboardCard(
      icon: Icons.free_breakfast_outlined,
      title: 'Time Off',
      route: Routes.timeoffScreen,
    ),
    const DashboardCard(
      icon: Icons.receipt_long_outlined,
      title: 'Payslips',
      route: Routes.payslipsScreen,
    ),
    const DashboardCard(
      icon: Icons.account_balance_wallet_outlined,
      title: 'Expenses',
      route: Routes.expensesScreen,
    ),
  ];
}
