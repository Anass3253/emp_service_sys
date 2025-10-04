import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_service_system/generated/l10n.dart';

class StateChip extends StatelessWidget {
  final String state;
  const StateChip({super.key, required this.state});

  Color _colorForState(String state) {
    switch (state.toLowerCase()) {
      case 'approved':
      case 'done':
        return Colors.green;
      case 'submitted':
      case 'pending':
        return Colors.orange;
      case 'refused':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final color = _colorForState(state);
    final localLang = S.of(context);
    String localizedState;
    switch (state.toLowerCase()) {
      case 'approved':
        localizedState = localLang.approved;
        break;
      case 'done':
        localizedState = localLang.done;
        break;
      case 'submitted':
        localizedState = localLang.submitted;
        break;
      case 'pending':
        localizedState = localLang.pending;
        break;
      case 'refused':
        localizedState = localLang.refused;
        break;
      case 'rejected':
        localizedState = localLang.rejected;
        break;
      default:
        localizedState = state[0].toUpperCase() + state.substring(1);
    }
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        localizedState,
        style: TextStyle(
          color: color,
          fontSize: screenHieght < 412? 8.sp : 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}