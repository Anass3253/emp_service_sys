import 'package:intl/intl.dart';

class Expenses {
  int? id;
  String description;
  String? category;
  double amount;
  String currency;
  DateTime date;
  String state;

  Expenses({
    this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    required this.state,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      description: json['description'],
      category: json['category'],
      amount: json['amount'],
      currency: json['currency'],
      date: DateTime.parse(json['date']),
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category_name": category,
      "amount": amount,
      "currency": currency,
      "date": DateFormat("yyyy-MM-dd", 'en').format(date).toString(),
      "description": description,
    };
  }
}

class Categories {
  String name;
  int? id;

  Categories({this.id, required this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(id: json['id'], name: json['name']);
  }
}
