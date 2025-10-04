import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:employee_service_system/generated/l10n.dart';

class TimeOffCard extends StatelessWidget {
  const TimeOffCard({super.key, required this.timeOff});
  final dynamic timeOff;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('MMM dd, yyyy');
    final Color stateColor = _stateColor(timeOff.state);
    final IconData icon = _typeIcon(timeOff.type);
    final String typeLabel = timeOff.type;
    final String stateLabel = _localizedState(context, timeOff.state);

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
                          stateLabel,
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
  final String t = type.toString().toLowerCase();
  
  // Regular/Annual leave
  if (t.contains('regular') || t.contains('اعتيادي') || t.contains('annual')) {
    return Icons.beach_access;
  }
  
  // Overtime
  if (t.contains('overtime') || t.contains('اضافي') || t.contains('extra')) {
    return Icons.timer;
  }
  
  // Emergency
  if (t.contains('emergency') || t.contains('عارضة') || t.contains('emergncy')) {
    return Icons.warning_amber_rounded;
  }
  
  // Permission
  if (t.contains('permission') || t.contains('اذن') || t.contains('premission')) {
    return Icons.assignment_turned_in;
  }
  
  // Visit
  if (t.contains('visit') || t.contains('زيارة')) {
    return Icons.handshake;
  }
  
  // Work From Home
  if (t.contains('work from home') || t.contains('home')) {
    return Icons.home_work;
  }
  
  // Unpaid
  if (t.contains('unpaid') || t.contains('بالخصم')) {
    return Icons.money_off;
  }
  
  // Wedding Leave
  if (t.contains('wedding')) {
    return Icons.celebration;
  }
  
  // Haj & Omra Leave
  if (t.contains('haj') || t.contains('omra') || t.contains('حج') || t.contains('عمرة')) {
    return Icons.mosque;
  }
  
  // Military Service Leave
  if (t.contains('military') || t.contains('عسكري')) {
    return Icons.shield;
  }
  
  // Sick Leave
  if (t.contains('sick') || t.contains('مرضي')) {
    return Icons.healing;
  }
  
  // Compensatory
  if (t.contains('compensatory') || t.contains('تعويض') || t.contains('compens')) {
    return Icons.restore;
  }
  
  // Default fallback
  return Icons.event;
}


String _localizedState(BuildContext context, String rawState) {
  final s = rawState.toLowerCase();
  // Group states and return localized label using existing S getters.
  if (s == 'approved' || s == 'validate' || s == 'done') {
    return S.of(context).approved;
  }
  if (s == 'pending' || s == 'to approve' || s == 'draft' || s == 'confirm') {
    return S.of(context).pending;
  }
  if (s == 'refused' || s == 'cancelled' || s == 'cancel') {
    return S.of(context).refused;
  }
  // Fallback: return as-is with simple capitalization.
  return rawState.isEmpty
      ? ''
      : rawState[0].toUpperCase() + rawState.substring(1);
}
