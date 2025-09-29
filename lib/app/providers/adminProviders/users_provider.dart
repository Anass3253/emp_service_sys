import 'dart:convert';

import 'package:employee_service_system/app/models/usersModels/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends StateNotifier<AsyncValue<List<Employee>>> {
  UsersProvider() : super(const AsyncValue.loading());

  Future<void> getUsers(String token) async {
    const url =
        "https://knowledgebi-staging-22637664.dev.odoo.com/knowledgebi-staging/api/employees";

    if (state.hasValue && state.value!.isNotEmpty) {
      return;
    }
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({"token": token}),
    );

    print(response.body);

    final responseData = json.decode(response.body);
    final empsList = responseData['employees'] as List<dynamic>;
    final List<Employee> usersList = empsList.map((e) => Employee.fromJson(e)).toList();
    state = AsyncValue.data(usersList);
  }
}

final usersProviders =
    StateNotifierProvider<UsersProvider, AsyncValue<List<Employee>>>(
      (ref) => UsersProvider(),
    );
