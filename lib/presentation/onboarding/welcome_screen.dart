import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _topContainer(context),
          SizedBox(height: 20.h,)
        ],
      )
    );
  }
}


Widget _topContainer(BuildContext context){
  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(100),
      ),
      color: Theme.of(context).colorScheme.primary,
    ),
    
  );
}