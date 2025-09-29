import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/app/kbi_app.dart';
import 'package:employee_service_system/app/providers/theme_provider.dart';
import 'package:employee_service_system/routing/app_router.dart';
import 'package:provider/provider.dart' as provider ; 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    provider.MultiProvider(providers: 
      [
        provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: riverpod.ProviderScope(child: KbiApp(appRouter: AppRouter(),)),
    )
  );
}


