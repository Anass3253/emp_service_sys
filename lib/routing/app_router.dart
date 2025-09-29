import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:employee_service_system/presentation/auth/idCheck/id_check_screen.dart';
import 'package:employee_service_system/presentation/employee/payslips/subscreens/payslip_details.dart';
import 'package:flutter/material.dart';
import 'package:employee_service_system/app_initialization.dart';
import 'package:employee_service_system/presentation/admin/home/admin_home_screen.dart';
import 'package:employee_service_system/presentation/admin/home/subScreens/user_details_screen.dart';
import 'package:employee_service_system/presentation/auth/signin/signin_screen.dart';
import 'package:employee_service_system/presentation/employee/profile/subScreen/about_me_screen.dart';
import 'package:employee_service_system/presentation/splash_screen.dart';
import 'package:employee_service_system/presentation/employee/attendance/attendance_screen.dart';
import 'package:employee_service_system/presentation/employee/expenses/expenses_screen.dart';
import 'package:employee_service_system/presentation/employee/home/home_screen.dart';
import 'package:employee_service_system/presentation/employee/payslips/payslips_screen.dart';
import 'package:employee_service_system/presentation/employee/timeOff/timeoff_screen.dart';
import 'package:employee_service_system/presentation/onboarding/welcome_screen.dart';
import 'package:employee_service_system/routing/routes.dart';

class AppRouter {
  AppRouter();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case Routes.idCheck:
        return MaterialPageRoute(builder: (_) => const IdCheckScreen());
      case Routes.appInit:
        return MaterialPageRoute(builder: (_) => const AppInitialization());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.attendanceScreen:
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case Routes.timeoffScreen:
        return MaterialPageRoute(builder: (_) => const TimeoffScreen());
      case Routes.payslipsScreen:
        return MaterialPageRoute(builder: (_) => const PayslipsScreen());
      case Routes.payslipDeatils:
      final index = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => PayslipDetails(index: index,));
      case Routes.expensesScreen:
        return MaterialPageRoute(builder: (_) => const ExpensesScreen());
      case Routes.aboutMeScreen:
        return MaterialPageRoute(builder: (_) => const AboutMeScreen());
      case Routes.adminHomeScreen:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      case Routes.userDetailsScreen:
        final user = settings.arguments as Employee;
        return MaterialPageRoute(builder: (_) => UserDetailsScreen(user: user));
      default:
        return null;
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("this is undefined Route")),
      ),
    );
  }
}
