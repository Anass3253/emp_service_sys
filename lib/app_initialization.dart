import 'package:flutter/material.dart';
import 'package:employee_service_system/presentation/employee/home/home_screen.dart';
import 'package:employee_service_system/presentation/employee/profile/my_profile.dart';
import 'package:employee_service_system/presentation/resources/my_app_bottom_navigation_bar.dart';

class AppInitialization extends StatefulWidget {
  const AppInitialization({super.key});

  @override
  State<AppInitialization> createState() => _AppInitializationState();
}

class _AppInitializationState extends State<AppInitialization> {
  // bool _isAdmin = false;
  @override
  Widget build(BuildContext context) {
    // return _isAdmin
    //     ? MyAppBottomNavigationBar(
    //         screens: [AdminHomeScreen(), MyProfile()],
    //         icons: [Icons.home_outlined, Icons.person_outline],
    //         labels: ["Home", "Profile"],
    //       )
    //     : MyAppBottomNavigationBar(
    //         screens: [HomeScreen(), MyProfile()],
    //         icons: [Icons.home_outlined, Icons.person_outline],
    //         labels: ["Home", "Profile"],
    //       );

    // return MyAppBottomNavigationBar(
    //   screens: [AdminHomeScreen(), MyProfile()],
    //   icons: [Icons.home_outlined, Icons.person_outline],
    //   labels: ["Home", "Profile"],
    // );
    return const MyAppBottomNavigationBar(
      screens: [HomeScreen(), MyProfile()],
      icons: [Icons.home_outlined, Icons.person_outline],
      labels: ["Home", "Profile"],
    );
  }
}
