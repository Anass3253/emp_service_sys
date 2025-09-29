class Payslips {
  int id;
  String reference;
  String name;
  String state;
  DateTime dateFrom;
  DateTime dateTo;
  DateTime? computedOn;
  List<Line>? lines;
  List<WorkedDays>? workedDays;

  Payslips({
    required this.id,
    required this.reference,
    required this.name,
    required this.state,
    required this.dateFrom,
    required this.dateTo,
    this.computedOn,
    this.lines,
    this.workedDays,
  });

  factory Payslips.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final String reference = json['reference'] ?? '';
    final String name = json['name'] ?? '';
    final String state = json['state'] ?? '';

    final String? dateFromStr = json['date_from'];
    final String? dateToStr = json['date_to'];

    final DateTime dateFrom = dateFromStr != null && dateFromStr.isNotEmpty
        ? DateTime.parse(dateFromStr)
        : DateTime.fromMillisecondsSinceEpoch(0);
    final DateTime dateTo = dateToStr != null && dateToStr.isNotEmpty
        ? DateTime.parse(dateToStr)
        : DateTime.fromMillisecondsSinceEpoch(0);

    // Optional fields present in details response
    final String? computedOnStr = json['computed_on'];
    final DateTime? computedOn =
        (computedOnStr != null && computedOnStr.isNotEmpty)
            ? DateTime.parse(computedOnStr)
            : null;

    final List<dynamic>? linesJson = json['lines'] as List<dynamic>?;
    final List<Line>? lines = linesJson
        ?.map((e) => Line.fromJson(e as Map<String, dynamic>))
        .toList();

    final List<dynamic>? workedDaysJson = json['worked_days'] as List<dynamic>?;
    final List<WorkedDays>? workedDays = workedDaysJson
        ?.map((e) => WorkedDays.fromJson(e as Map<String, dynamic>))
        .toList();

    return Payslips(
      id: id,
      reference: reference,
      name: name,
      state: state,
      dateFrom: dateFrom,
      dateTo: dateTo,
      computedOn: computedOn,
      lines: lines,
      workedDays: workedDays,
    );
  }
}

class Contract {
  String startDate;
  String contractType;
  String workingSchedule;

  Contract({
    required this.startDate,
    required this.contractType,
    required this.workingSchedule,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      startDate: json['start_date'],
      contractType: json['contract_type'],
      workingSchedule: json['working_schedule'],
    );
  }
}

class Line {
  String name;
  double total;

  Line({required this.name, required this.total});

  factory Line.fromJson(Map<String, dynamic> json) {
    final num totalNum = (json['total'] ?? 0) as num;
    return Line(name: json['name'] ?? '', total: totalNum.toDouble());
  }
}

class WorkedDays {
  String name;
  double numberOfHours;
  double numberOfDays;
  double amount;

  WorkedDays({
    required this.name,
    required this.numberOfHours,
    required this.numberOfDays,
    required this.amount,
  });

  factory WorkedDays.fromJson(Map<String, dynamic> json) {
    final num hoursNum = (json['number_of_hours'] ?? 0) as num;
    final num daysNum = (json['number_of_days'] ?? 0) as num;
    final num amountNum = (json['amount'] ?? 0) as num;
    return WorkedDays(
      name: json['name'] ?? '',
      numberOfHours: hoursNum.toDouble(),
      numberOfDays: daysNum.toDouble(),
      amount: amountNum.toDouble(),
    );
  }
}
