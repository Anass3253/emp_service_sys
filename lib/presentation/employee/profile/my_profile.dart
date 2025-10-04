import 'package:employee_service_system/app/providers/ui_providers/language_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:employee_service_system/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final localeLang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/knowledge Bi.png',
            height: 65.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.grey),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.aboutMeScreen);
            },
            child: ListTile(
              title: Text(localeLang.aboutMe),
              trailing: const Icon(Icons.person_2_outlined),
            ),
          ),
          const Divider(color: Colors.grey),
          GestureDetector(
            onTap: () {
              Provider.of<LanguageProvider>(
                context,
                listen: false,
              ).toggleLanguage();
            },
            child: ListTile(
              title: Text(localeLang.changeLanguage),
              trailing: const Icon(Icons.language_outlined, color: Colors.black),
            ),
          ),
          const Divider(color: Colors.grey),
          GestureDetector(
            onTap: () async {
              await PrefService.logOut();
              await PrefService.deleteToken();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, Routes.signin);
              }
            },
            child: ListTile(
              title: Text(localeLang.logOut),
              trailing: const Icon(Icons.logout_outlined, color: Colors.red),
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
