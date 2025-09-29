import 'package:employee_service_system/app/models/usersModels/user.dart';

class Admin extends User {

  String token;

  Admin({required super.id, required super.name, required this.token});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      token: json['token'] ?? "",
    );
  }
}
