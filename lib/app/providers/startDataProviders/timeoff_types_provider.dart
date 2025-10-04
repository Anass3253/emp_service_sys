import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/time_off.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class TimeoffTypesProvider extends StateNotifier<List<Types>> {
  TimeoffTypesProvider() : super([]);

  Future<void> getTimeoffsTypes(String token) async {
    const baseUri = 'https://knowledgebi.odoo.com/';
    // const baseUri = 'https://knowledgebi-staging-22637664.dev.odoo.com/';
    const typesUri = "${baseUri}knowledgebi-staging/api/employee/timeoff/types";
    try {
      final typesResponse = await http.post(
        Uri.parse(typesUri),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );
      final responseData = json.decode(typesResponse.body);
      if (responseData['status'] == 'success') {
        final typesList = responseData['timeoff_types'] as List<dynamic>;
        final List<Types> types = typesList
            .map((e) => Types.fromJson(e))
            .toList();
        state = types;
      }
    } catch (e) {
      throw Exception('Failed to fetch Categories');
    }
  }
}

final timeoffTypesProvider =
    StateNotifierProvider<TimeoffTypesProvider, List<Types>>(
      (ref) => TimeoffTypesProvider(),
    );
