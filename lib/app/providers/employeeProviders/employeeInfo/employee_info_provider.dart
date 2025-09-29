import 'dart:convert';

import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class EmployeeInfoProvider extends StateNotifier<AsyncValue<Employee>> {
  EmployeeInfoProvider() : super(const AsyncValue.loading());
  final baseUri = 'https://knowledgebi.odoo.com/';

  Future<void> idChecker(String id, String token, String? mobileId) async {
    final infoUri = "${baseUri}knowledgebi-staging/api/employees";
    try {
      final infoResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(infoUri),
        body: json.encode({
          'token': token,
          'employee_code': id,
          'employee_mobile_ip': mobileId,
        }),
      );
      final responseData = json.decode(infoResponse.body);
      if (responseData["status"] == "success") {
        final currentEmp = Employee.fromJson(responseData['employees'][0]);
        currentEmp.empId = int.tryParse(id);
        state = AsyncData(currentEmp);
      } else if (infoResponse.statusCode == 403) {
        throw Exception('Can\'t verify from the current phone');
      } else {
        throw Exception('Invalid ID');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Find Employee with the given ID');
    }
  }
}

final empInfoProvider =
    StateNotifierProvider<EmployeeInfoProvider, AsyncValue<Employee>>(
      (ref) => EmployeeInfoProvider(),
    );
