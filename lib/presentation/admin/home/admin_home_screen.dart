import 'package:employee_service_system/app/providers/adminProviders/admin_auth_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/app/providers/adminProviders/users_provider.dart';
import 'package:employee_service_system/presentation/admin/home/widgets/add_user_sheet.dart';
import 'package:employee_service_system/presentation/resources/gradient_appbar.dart';
import 'package:employee_service_system/presentation/resources/theme_manager.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:employee_service_system/routing/routes.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() async {
      final isLoggedIn = await PrefService.isLoggedIn();
      if (isLoggedIn) {
        final currentToken = await PrefService.getToken();
        if (currentToken != null) {
          return ref.read(usersProviders.notifier).getUsers(currentToken);
        }
      } else {
        final admin = ref.read(adminAuthProvider);
        if (admin.hasValue && admin.value != null) {
          return ref.read(usersProviders.notifier).getUsers(admin.value!.token);
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    Future.microtask(() async {
      final isLoggedIn = await PrefService.isLoggedIn();
      if (isLoggedIn) {
        final currentToken = await PrefService.getToken();
        if (currentToken != null) {
          return ref.read(usersProviders.notifier).getUsers(currentToken);
        }
      } else {
        final admin = ref.read(adminAuthProvider);
        if (admin.hasValue && admin.value != null) {
          return ref.read(usersProviders.notifier).getUsers(admin.value!.token);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersList = ref.watch(usersProviders);

    void editBottomSheet() async {
      final result = await showModalBottomSheet(
        showDragHandle: true,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        constraints: const BoxConstraints(maxHeight: double.infinity),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const AddUserSheet();
        },
      );

      print(result);
      setState(() {});
    }

    return Scaffold(
      appBar: GradientAppbar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.appInit);
            },
            icon: const Icon(Icons.person_2_outlined, size: 35),
          ),
        ],
        imagePath: 'assets/images/KBI_logo2.png',
        title: 'Knowledge BI',
        gradient: Theme.of(context).extension<GradientTheme>()!.appBarGradient,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome Admin',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: editBottomSheet,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              usersList.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: usersList.value!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.userDetailsScreen,
                          arguments: usersList.value![index],
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(15.r),
                              // gradient: Theme.of(
                              //   context,
                              // ).extension<BackgroundTheme>()!.scaffoldGradient,
                            ),
                            child: ListTile(
                              title: Text(usersList.value![index].name),
                              subtitle: Text(usersList.value![index].workEmail),
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        usersList.value!.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    const Center(child: Text('Error Loading Users')),
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
