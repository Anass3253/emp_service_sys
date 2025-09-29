import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivInfoScreen extends StatefulWidget {
  const PrivInfoScreen({super.key, required this.user});
  final Employee user;
  @override
  State<PrivInfoScreen> createState() => _PrivInfoScreenState();
}

class _PrivInfoScreenState extends State<PrivInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            'PRIVATE CONTACT',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          //---------------------------------------
          SizedBox(height: 15.h),
          Text('Address', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 5.h),
          Text(
            widget.user.addressId,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //-----------------------------------------------         
          SizedBox(height: 15.h),
          Text('Language', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 5.h),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Home-Work Distance',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 5.h),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //--------------------------------------------------------
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('JOB POSITION', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            'Certificate Level',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.certificate,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //-----------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Field of Study',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          SizedBox(height: 5.h),
          Text(
            widget.user.studyField,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'School',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          SizedBox(height: 5.h),
          Text(
            widget.user.studySchool,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //-----------------------------------------------------------
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('WORK PERMIT', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            'Visa No',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.visaNo,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //-----------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Work Permit No',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.permitNo,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //-------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Visa Expire Date',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //--------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Work Permit Expiration Date',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('FAMILY STATUS', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            'Marital Status',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.marital,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Number of Dependent Children',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.children.toString(),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //------------------------------------------------------------
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('EMERGENCY', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            'Contact Name',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.emergencyContact,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Contact Phone',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.emergencyPhone,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //------------------------------------------------------
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),
          Text('CITIZENSHIP', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            'Nationality(Country)',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.placeOfBirth,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Identification No',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.identificationId,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //----------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Passport No',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.passportId,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //----------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Gender',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.gender,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //-------------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Date of Birth',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            'Dummy...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //--------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Place of Birth',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.placeOfBirth,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          //---------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            'Country of Birth',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge,
          ),
          Text(
            widget.user.placeOfBirth,
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
