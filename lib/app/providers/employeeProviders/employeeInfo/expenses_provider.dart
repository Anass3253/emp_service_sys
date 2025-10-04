import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/expenses.dart';
import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends StateNotifier<AsyncValue<List<Expenses>>> {
  ExpensesProvider() : super(const AsyncLoading());
  final baseUri = 'https://knowledgebi.odoo.com/';
  // final baseUri = 'https://knowledgebi-staging-22637664.dev.odoo.com/';
  Future<void> getExpenses(String token, Employee currentEmp) async {
    final expensesUri = "${baseUri}knowledgebi-staging/api/employee/expense";
    try {
      final expensesResponse = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(expensesUri),
        body: json.encode({'token': token, 'employee_code': currentEmp.empId}),
      );
      final responseData = json.decode(expensesResponse.body);
      if (responseData['status'] == 'success') {
        final expensesList = responseData['expenses'] as List<dynamic>;
        final expenses = expensesList.map((e) => Expenses.fromJson(e)).toList();
        state = AsyncData(expenses);
      } else if (expensesResponse.statusCode == 404) {
        state = const AsyncData([]);
      } else {
        throw Exception('Something Went Wrong');
      }
    } catch (e) {
      throw Exception('Failed to Fetch Data');
    }
  }

  Future<bool> addExpense(
    Expenses newExpense,
    Employee currentEmp,
    String token,
  ) async {
    final postExpenseUri =
        "${baseUri}knowledgebi-staging/api/employee/expense/create";

    final jsonExpense = newExpense.toJson();
    print(jsonExpense);
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(postExpenseUri),
        body: json.encode({
          "employee_code": currentEmp.empId,
          "token": token,
          "category_name": jsonExpense['category_name'],
          "amount": jsonExpense['amount'],
          "currency": jsonExpense['currency'],
          "date": jsonExpense['date'],
          "description": jsonExpense['description'],
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

final expensesProvider =
    StateNotifierProvider<ExpensesProvider, AsyncValue<List<Expenses>>>(
      (ref) => ExpensesProvider(),
    );
