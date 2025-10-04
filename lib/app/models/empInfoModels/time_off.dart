import 'package:intl/intl.dart';

class TimeOff {
  int? id;
  String? type;
  DateTime dateFrom;
  DateTime dateTo;
  String description;
  String state;

  TimeOff({
    this.id,
    required this.type,
    required this.dateFrom,
    required this.dateTo,
    required this.description,
    required this.state,
  });

  factory TimeOff.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final String type = (json['type'] ?? '').toString();

    final String? fromStr = json['date_from']?.toString();
    final String? toStr = json['date_to']?.toString();

    return TimeOff(
      id: id,
      type: type,
      dateFrom: fromStr != null && fromStr.isNotEmpty
          ? DateTime.parse(fromStr)
          : DateTime.fromMillisecondsSinceEpoch(0),
      dateTo: toStr != null && toStr.isNotEmpty
          ? DateTime.parse(toStr)
          : DateTime.fromMillisecondsSinceEpoch(0),
      description: (json['description'] ?? '').toString(),
      state: (json['state'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'date_from': DateFormat("yyyy-MM-dd", 'en').format(dateFrom).toString(),
      'date_to': DateFormat("yyyy-MM-dd", 'en').format(dateTo).toString(),
      'description': description,
      'state': state,
    };
  }
}

class Types {
  String name;
  int? id;

  Types({required this.name, required this.id});

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(name: json['name'], id: json['id']);
  }
}
