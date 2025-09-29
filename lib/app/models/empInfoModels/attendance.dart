import 'package:intl/intl.dart';

class Attendance {
  int? id;
  DateTime checkIn;
  DateTime? checkOut;
  double? workedHrs;

  Attendance({this.id, required this.checkIn, this.checkOut, this.workedHrs});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    final DateTime? checkout;
    if (json['check_out'] == '') {
      checkout = null;
    }else{
      checkout = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['check_out']);
    }
    return Attendance(
      id: json['id'] ?? 0,
      checkIn: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['check_in']),
      checkOut: checkout,
      workedHrs: double.parse(
        ((double.tryParse(json['worked_hours'].toString()) ?? 0.0)
            .toStringAsFixed(2)),
      ),
    );
  }
}
