import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:employee_service_system/generated/l10n.dart';
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
    final localeLang = S.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            localeLang.privateContact,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          //---------------------------------------
          SizedBox(height: 15.h),
          Text(localeLang.address, style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 5.h),
          Text(
            widget.user.addressId,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          //-----------------------------------------------         
          SizedBox(height: 15.h),
          Text(localeLang.language, style: Theme.of(context).textTheme.bodyLarge),
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
            localeLang.homeWorkDistance,
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
          Text(localeLang.jobPosition, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            localeLang.certificateLevel,
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
            localeLang.fieldOfStudy,
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
            localeLang.school,
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
          Text(localeLang.workPermit, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          Text(
            localeLang.visaNo,
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
            localeLang.workPermitNo,
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
            localeLang.visaExpireDate,
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
            localeLang.workPermitExpirationDate,
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
          Text(localeLang.familyStatus, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            localeLang.maritalStatus,
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
            localeLang.dependentChildren,
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
          Text(localeLang.emergency, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            localeLang.contactName,
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
            localeLang.contactPhone,
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
          Text(localeLang.citizenship, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Text(
            localeLang.nationality,
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
            localeLang.identificationNo,
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
            localeLang.passportNo,
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
            localeLang.gender,
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
            localeLang.dateOfBirth,
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
            localeLang.placeOfBirth,
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
            localeLang.countryOfBirth,
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
