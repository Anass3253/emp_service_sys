import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key, required this.user});
  final Employee user;

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text('Department', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.department,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Job Position', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.jobTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Manager', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.manager,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Coach', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.manager,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Working Hours', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Work Address', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.addressId,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Work Location', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Work Mobile', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.workPhone,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('Work Phone', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            widget.user.mobilePhone,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
