import 'package:employee_service_system/app/providers/ui_providers/language_provider.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/routing/app_router.dart';
import 'package:employee_service_system/presentation/resources/theme_manager.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:employee_service_system/routing/routes.dart';
import 'package:provider/provider.dart';

class KbiApp extends StatelessWidget {
  const KbiApp._instance({required this.appRouter});
  final AppRouter appRouter;

  factory KbiApp({required AppRouter appRouter}) {
    return KbiApp._instance(appRouter: appRouter);
  }
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: 'Knowledge BI HR',
          themeMode: ThemeMode.light,
          theme: ThemeManager.lightTheme,
          // darkTheme: ThemeManager.darkTheme,
          initialRoute: Routes.splash,
          // initialRoute: Routes.homeScreen,
          onGenerateRoute: appRouter.generateRoute,
          locale: languageProvider.locale,
          // locale: const Locale('ar'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
