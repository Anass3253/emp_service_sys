import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/attendance.dart';
import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AttendanceProvider extends StateNotifier<AsyncValue<List<Attendance>>> {
  AttendanceProvider() : super(const AsyncLoading());
  final baseUri = 'https://knowledgebi.odoo.com/';
  // final baseUri = 'https://knowledgebi-staging-22637664.dev.odoo.com/';

  Future<void> getAttendance(String token, Employee currentEmp) async {
    final attendanceUri =
        '${baseUri}knowledgebi-staging/api/employee/attendance';
    try {
      final infoResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(attendanceUri),
        body: json.encode({'token': token, 'employee_code': currentEmp.empId}),
      );
      final responseData = json.decode(infoResponse.body);
      if (responseData["status"] == "success") {
        final attendancesList = responseData['attendances'] as List<dynamic>;
        final List<Attendance> attendances = attendancesList
            .map((e) => Attendance.fromJson(e))
            .toList();
        currentEmp.attendance = attendances;
        state = AsyncData(attendances);
      } else if (infoResponse.statusCode == 404) {
        state = const AsyncData([]);
      } 
      else {
        throw Exception('Invalid ID');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Fetch Data');
    }
  }

  Future<void> createAttendance(
    Employee currentEmp,
    String token,
    String checkIn,
    String checkOut,
  ) async {
    final createAttendanceUri =
        '${baseUri}knowledgebi-staging/api/employee/attendance/create';
    try {
      final createAttendanceResponse = await http.post(
        Uri.parse(createAttendanceUri),
        body: json.encode({
          "employee_code": currentEmp.empId,
          "token": token,
          "check_in": checkIn,
          "check_out": checkOut,
        }),
      );

      final responseData = json.decode(createAttendanceResponse.body);
      if (responseData['status'] == 'success') {
        return;
      } else {
        throw Exception('Something went wrong: ${responseData['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create Attendance Record due to $e');
    }
  }
}

final attendanceProvider =
    StateNotifierProvider<AttendanceProvider, AsyncValue<List<Attendance>>>(
      (ref) => AttendanceProvider(),
    );
