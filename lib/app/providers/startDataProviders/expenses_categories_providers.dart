import 'dart:convert';

import 'package:employee_service_system/app/models/empInfoModels/expenses.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ExpensesCategoriesProviders extends StateNotifier<List<Categories>> {
  ExpensesCategoriesProviders() : super([]);

  Future<void> getExpensesCategories(String token) async {
    const baseUri = 'https://knowledgebi.odoo.com/';
    const categoriesUri = "${baseUri}knowledgebi-staging/api/expense/categories";
    try {
      final categResponse = await http.post(
        Uri.parse(categoriesUri),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );
      final responseData = json.decode(categResponse.body);
      if (responseData['status'] == 'success') {
        final categoriesList = responseData['categories'] as List<dynamic>;
        final List<Categories> categories = categoriesList
            .map((e) => Categories.fromJson(e))
            .toList();
        state = categories;
      }
    } catch (e) {
      throw Exception('Failed to fetch Categories');
    }
  }
}

final expensesCategoriesProvider =
    StateNotifierProvider<ExpensesCategoriesProviders, List<Categories>>(
      (ref) => ExpensesCategoriesProviders(),
    );
