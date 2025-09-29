import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TimeOffCard extends StatelessWidget {
  const TimeOffCard({super.key, required this.timeOff});
  final dynamic timeOff;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('MMM dd, yyyy');
    final Color stateColor = _stateColor(timeOff.state);
    final IconData icon = _typeIcon(timeOff.type);
    final String typeLabel = _typeLabel(timeOff.type);

    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: stateColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: stateColor, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          typeLabel,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: stateColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          timeOff.state.toString().toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: stateColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${df.format(timeOff.dateFrom)}  -  ${df.format(timeOff.dateTo)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.8),
                              ),
                        ),
                      ),
                    ],
                  ),
                  if (timeOff.description != null &&
                      timeOff.description.toString().isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      timeOff.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _stateColor(String state) {
  switch (state.toLowerCase()) {
    case 'approved':
    case 'validate':
    case 'done':
      return Colors.green;
    case 'pending':
    case 'to approve':
    case 'draft':
      return Colors.orange;
    case 'refused':
    case 'cancelled':
    case 'cancel':
      return Colors.red;
    default:
      return Colors.blueGrey;
  }
}

IconData _typeIcon(dynamic type) {
  final String t = type.toString();
  if (t.contains('annual') || t.contains('forward')) return Icons.beach_access;
  if (t.contains('sick')) return Icons.healing;
  if (t.contains('emergency')) return Icons.warning_amber_rounded;
  if (t.contains('unpaid')) return Icons.money_off;
  if (t.contains('client') || t.contains('visit')) return Icons.handshake;
  if (t.contains('wedding') || t.contains('haj') || t.contains('omra')) {
    return Icons.celebration;
  }
  if (t.contains('military')) return Icons.shield;
  if (t.contains('extra') || t.contains('compens')) return Icons.timer;
  return Icons.event;
}

String _typeLabel(dynamic type) {
  final String t = type.toString();
  return t
      .replaceAll('TimeOffTypes.', '')
      .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}')
      .replaceAll('_', ' ')
      .trim()
      .splitMapJoin(
        ' ',
        onNonMatch: (s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1),
      );
}
