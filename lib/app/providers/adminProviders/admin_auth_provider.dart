import 'dart:convert';

import 'package:employee_service_system/app/models/usersModels/admin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AdminAuthProvider extends StateNotifier<AsyncValue<Admin>> {
  AdminAuthProvider() : super(const AsyncValue.loading());
  Future<void> signInAdmin(String email, String password) async {
    const url =
        "https://knowledgebi.odoo.com/knowledgebi-staging/api/login";
    // const url =
    //     "https://knowledgebi-staging-22637664.dev.odoo.com/knowledgebi-staging/api/login";
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(url),
        body: json.encode({"username": email, "password": password}),
      );

      print(response.body);
      final responseData = json.decode(response.body);

      if (responseData["status"] == "success") {
        final user = Admin.fromJson(responseData);
        state = AsyncValue.data(user);
      } else {
        throw Exception('Invalid Credentials');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to login');
    }
  }
}

final adminAuthProvider =
    StateNotifierProvider<AdminAuthProvider, AsyncValue<Admin>>(
      (ref) => AdminAuthProvider(),
    );
