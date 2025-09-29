import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/routing/app_router.dart';
import 'package:employee_service_system/presentation/resources/theme_manager.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:employee_service_system/routing/routes.dart';

class KbiApp extends StatelessWidget {
  const KbiApp._instance({required this.appRouter});
  final AppRouter appRouter;

  factory KbiApp({required AppRouter appRouter}) {
    return KbiApp._instance(appRouter: appRouter);
  }
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: 'Knowledge BI HR',
          themeMode: ThemeMode.system,
          theme: ThemeManager.lightTheme,
          // darkTheme: ThemeManager.darkTheme,
          initialRoute: Routes.splash,
          // initialRoute: Routes.homeScreen,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
