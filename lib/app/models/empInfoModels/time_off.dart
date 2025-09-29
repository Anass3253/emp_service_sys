import 'package:intl/intl.dart';

enum TimeOffTypes {
  // annualLeave,
  // emergencyLeave,
  // forwardedLeave,
  clientVisit,
  // demoOnPrimes,
  unpaid,
  // weddingLeave,
  // hajOmraLeave,
  // militaryLeave,
  sickTimeOff,
  extraHours,
  // compensatoryDays,
}

class TimeOff {
  int? id;
  TimeOffTypes type;
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
    final String rawType = (json['type'] ?? '').toString();
    final TimeOffTypes mappedType = _mapType(rawType);

    final String? fromStr = json['date_from']?.toString();
    final String? toStr = json['date_to']?.toString();

    return TimeOff(
      id: id,
      type: mappedType,
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
      'type': _typeToString(type),
      'date_from': DateFormat("yyyy-MM-dd").format(dateFrom).toString(),
      'date_to': DateFormat("yyyy-MM-dd").format(dateTo).toString(),
      'description': description,
      'state': state,
    };
  }
}

TimeOffTypes _mapType(String raw) {
  final normalized = raw.toLowerCase().replaceAll(' ', '').replaceAll('_', '');
  // if (normalized.contains('annual')) return TimeOffTypes.annualLeave;
  // if (normalized.contains('emergency')) return TimeOffTypes.emergencyLeave;
  // if (normalized.contains('forward')) return TimeOffTypes.forwardedLeave;
  if (normalized.contains('client') || normalized.contains('visit')) return TimeOffTypes.clientVisit;
  // if (normalized.contains('demo')) return TimeOffTypes.demoOnPrimes;
  if (normalized.contains('unpaid')) return TimeOffTypes.unpaid;
  // if (normalized.contains('wedding')) return TimeOffTypes.weddingLeave;
  // if (normalized.contains('haj') || normalized.contains('omra')) return TimeOffTypes.hajOmraLeave;
  // if (normalized.contains('military')) return TimeOffTypes.militaryLeave;
  if (normalized.contains('sick')) return TimeOffTypes.sickTimeOff;
  if (normalized.contains('extrahour') || normalized.contains('extra')) return TimeOffTypes.extraHours;
  // if (normalized.contains('compens')) return TimeOffTypes.compensatoryDays;
  return TimeOffTypes.clientVisit;
}

String _typeToString(TimeOffTypes type) {
  switch (type) {
    // case TimeOffTypes.annualLeave:
    //   return 'Annual Leave';
    // case TimeOffTypes.emergencyLeave:
    //   return 'Emergency Leave';
    // case TimeOffTypes.forwardedLeave:
    //   return 'Forwarded Leave';
    case TimeOffTypes.clientVisit:
      return 'Client Visit';
    // case TimeOffTypes.demoOnPrimes:
    //   return 'Demo On Primes';
    case TimeOffTypes.unpaid:
      return 'Unpaid';
    // case TimeOffTypes.weddingLeave:
    //   return 'Wedding Leave';
    // case TimeOffTypes.hajOmraLeave:
    //   return 'Haj & Omra Leave';
    // case TimeOffTypes.militaryLeave:
    //   return 'Military Leave';
    case TimeOffTypes.sickTimeOff:
      return 'Sick Time Off';
    case TimeOffTypes.extraHours:
      return 'Extra Hours';
    // case TimeOffTypes.compensatoryDays:
    //   return 'Compensatory Days';
  }
}
