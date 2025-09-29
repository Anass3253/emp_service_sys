import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:flutter/material.dart';
import 'package:employee_service_system/routing/routes.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          const Divider(color: Colors.grey),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.aboutMeScreen);
            },
            child: const ListTile(
              title: Text('About me'),
              trailing: Icon(Icons.person_2_outlined),
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
            child: const ListTile(
              title: Text('Log out'),
              trailing: Icon(Icons.logout_outlined, color: Colors.red),
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
