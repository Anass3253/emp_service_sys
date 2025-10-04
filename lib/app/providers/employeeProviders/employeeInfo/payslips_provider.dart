import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/payslips.dart';
import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class PayslipsProvider extends StateNotifier<AsyncValue<List<Payslips>>> {
  PayslipsProvider() : super(const AsyncLoading());
  final baseUri = 'https://knowledgebi.odoo.com/';
  // final baseUri = 'https://knowledgebi-staging-22637664.dev.odoo.com/';

  Future<void> getPayslips(String token, Employee currentEmp) async {
    final payslipsUri = '${baseUri}knowledgebi-staging/api/employee/payslip';
    try {
      final infoResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(payslipsUri),
        body: json.encode({'token': token, 'employee_code': currentEmp.empId}),
      );
      final responseData = json.decode(infoResponse.body);
      if (responseData["status"] == "success") {
        final payslipsList = responseData['payslips'] as List<dynamic>;
        final List<Payslips> payslips = payslipsList
            .map((e) => Payslips.fromJson(e))
            .toList();
        currentEmp.payslips = payslips;
        state = AsyncData(payslips);
      } else if (infoResponse.statusCode == 404) {
        state = const AsyncData([]);
      } else {
        throw Exception('Invalid ID');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Fetch Data');
    }
  }

  Future<void> getPayslipsDetails(
    currentPayslip,
    String token,
    Employee currentEmp,
  ) async {
    final detailsUri =
        "${baseUri}knowledgebi-staging/api/employee/payslip/details";
    try {
      final payslipDetailsResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(detailsUri),
        body: json.encode({'token': token, 'payslip_id': currentPayslip.id}),
      );
      final responseData = json.decode(payslipDetailsResponse.body);
      if (responseData["status"] == "success") {
        final Map<String, dynamic> payslipJson =
            (responseData['payslip'] ?? {}) as Map<String, dynamic>;
        final Payslips detailedPayslip = Payslips.fromJson(payslipJson);

        final int index = currentEmp.payslips!.indexWhere(
          (p) => p.id == detailedPayslip.id,
        );
        currentEmp.payslips![index] = detailedPayslip;

        state = AsyncData(currentEmp.payslips!);
      } else {
        throw Exception('Invalid ID');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to Fetch Data');
    }
  }
}

final payslipsProvider =
    StateNotifierProvider<PayslipsProvider, AsyncValue<List<Payslips>>>(
      (ref) => PayslipsProvider(),
    );
