import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/time_off.dart';
import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class TimeOffsProvider extends StateNotifier<AsyncValue<List<TimeOff>>> {
  TimeOffsProvider() : super(const AsyncLoading());
  final baseUri = 'https://knowledgebi.odoo.com/';

  Future<void> getTimeOffs(Employee currentEmp, String token) async {
    final timeOffsUri = "${baseUri}knowledgebi-staging/api/employee/timeoff";
    try {
      final timeOffsResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(timeOffsUri),
        body: json.encode({'token': token, 'employee_code': currentEmp.empId}),
      );
      final responseData = json.decode(timeOffsResponse.body);

      if (responseData['status'] == 'success') {
        final timeOffsList = responseData['timeoff'] as List<dynamic>;
        final List<TimeOff> timeOffs = timeOffsList
            .map((e) => TimeOff.fromJson(e))
            .toList();
        currentEmp.timeOff = timeOffs;
        state = AsyncData(timeOffs);
      } else if (timeOffsResponse.statusCode == 404) {
        state = const AsyncData([]);
      } else {
        throw Exception('Invalid token or employee ID');
      }
    } catch (e) {
      throw Exception('Failed to Fetch Data');
    }
  }

  Future<bool> addTimeOff(
    TimeOff newTimeOff,
    Employee currentEmp,
    String token,
  ) async {
    final postTimeOffUri =
        "${baseUri}knowledgebi-staging/api/employee/timeoff/create";

    final jsonTimeOff = newTimeOff.toJson();
    print(jsonTimeOff);
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(postTimeOffUri),
        body: json.encode({
          "employee_code": currentEmp.empId,
          "token": token,
          "leave_type_name": jsonTimeOff['type'],
          "date_from": jsonTimeOff['date_from'],
          "date_to": jsonTimeOff['date_to'],
          "description": jsonTimeOff['description'],
        }),
      );
      print('request sent!!!!!!!!!!');
      print(response.statusCode);
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          "error creating Request with ${responseData['message']}",
        );
      }
    } catch (e) {
      throw Exception('Failed to Add Data');
    }
  }
}

final timeOffProvider =
    StateNotifierProvider<TimeOffsProvider, AsyncValue<List<TimeOff>>>(
      (ref) => TimeOffsProvider(),
    );
