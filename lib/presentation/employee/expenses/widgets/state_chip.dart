import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final color = _colorForState(state);
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        state[0].toUpperCase() + state.substring(1),
        style: TextStyle(
          color: color,
          fontSize: screenHieght < 412? 8.sp : 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}