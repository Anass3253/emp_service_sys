import 'package:employee_service_system/app/models/empInfoModels/attendance.dart';
import 'package:employee_service_system/app/models/empInfoModels/payslips.dart';
import 'package:employee_service_system/app/models/empInfoModels/time_off.dart';
import 'package:employee_service_system/app/models/usersModels/user.dart';

class Employee extends User {
  int? empId;
  String jobTitle;
  String workEmail;
  String workPhone;
  String mobilePhone;
  String companyId;
  String department;
  String jobId;
  String manager;
  String resourceCalendarId;
  String addressId;
  String certificate;
  String studyField;
  String studySchool;
  String marital;
  int children;
  String emergencyContact;
  String emergencyPhone;
  String visaNo;
  String permitNo;
  String identificationId;
  String passportId;
  String gender;
  String placeOfBirth;
  List<Attendance>? attendance;
  List<Payslips>? payslips;
  List<TimeOff>? timeOff;

  Employee({
    required super.id,
    required super.name,
    this.empId,
    required this.jobTitle,
    required this.workEmail,
    required this.workPhone,
    required this.mobilePhone,
    required this.companyId,
    required this.department,
    required this.jobId,
    required this.manager,
    required this.resourceCalendarId,
    required this.addressId,
    required this.certificate,
    required this.studyField,
    required this.studySchool,
    required this.marital,
    required this.children,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.visaNo,
    required this.permitNo,
    required this.identificationId,
    required this.passportId,
    required this.gender,
    required this.placeOfBirth,
    this.attendance,
    this.payslips,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      jobTitle: json['job_title'] ?? "",
      workEmail: json['work_email'] ?? "",
      workPhone: json['work_phone'] ?? "",
      mobilePhone: json['mobile_phone'] ?? "",
      companyId: json['company_id'] ?? "",
      department: json['department'] ?? "",
      jobId: json['job_id'] ?? "",
      manager: json['manager'] ?? "",
      resourceCalendarId: json['resource_calendar_id'] ?? "",
      addressId: json['address_id'] ?? "",
      certificate: json['certificate'] ?? "",
      studyField: json['study_field'] ?? "",
      studySchool: json['study_school'] ?? "",
      marital: json['marital'] ?? "",
      children: json['children'] == "" ? 0 : json['children'],
      emergencyContact: json['emergency_contact'] ?? "",
      emergencyPhone: json['emergency_phone'] ?? "",
      visaNo: json['visa_no'] ?? "",
      permitNo: json['permit_no'] ?? "",
      identificationId: json['identification_id'] ?? "",
      passportId: json['passport_id'] ?? "",
      gender: json['gender'] ?? "",
      placeOfBirth: json['place_of_birth'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "job_title": jobTitle,
      "work_email": workEmail,
      "work_phone": workPhone,
      "mobile_phone": mobilePhone,
      "company_id": companyId,
      "department": department,
      "job_id": jobId,
      "manager": manager,
      "resource_calendar_id": resourceCalendarId,
      "address_id": addressId,
      "certificate": certificate,
      "study_field": studyField,
      "study_school": studySchool,
      "marital": marital,
      "children": children,
      "emergency_contact": emergencyContact,
      "emergency_phone": emergencyPhone,
      "visa_no": visaNo,
      "permit_no": permitNo,
      "identification_id": identificationId,
      "passport_id": passportId,
      "gender": gender,
      "place_of_birth": placeOfBirth,
    };
  }
}


