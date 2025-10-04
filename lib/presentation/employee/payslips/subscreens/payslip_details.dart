import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/payslips_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayslipDetails extends ConsumerStatefulWidget {
  const PayslipDetails({super.key, required this.index});
  final int index;
  @override
  ConsumerState<PayslipDetails> createState() => _PayslipDetailsState();
}

class _PayslipDetailsState extends ConsumerState<PayslipDetails>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        final currentPayslip = ref.read(payslipsProvider).value![widget.index];
        if (currentEmp != null) {
          return ref
              .read(payslipsProvider.notifier)
              .getPayslipsDetails(currentPayslip, currentToken, currentEmp);
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        final currentPayslip = ref.read(payslipsProvider).value![widget.index];

        if (currentEmp != null) {
          return ref
              .read(payslipsProvider.notifier)
              .getPayslipsDetails(currentPayslip, currentToken, currentEmp);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeLang = S.of(context);
    final payslipsAsync = ref.watch(payslipsProvider);
    final currentEmp = ref.watch(empInfoProvider).value;
    return Scaffold(
      appBar: AppBar(title: Text(localeLang.payslipDetails)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: payslipsAsync.when(
          data: (payslipses) {
            final payslips = payslipses[widget.index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeLang.employeeSection,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        SizedBox(height: 5.h),
                        _buildInfoRow(
                          context,
                          localeLang.name,
                          currentEmp!.name,
                        ),
                        _buildInfoRow(
                          context,
                          localeLang.marital,
                          currentEmp.marital,
                        ),
                        _buildInfoRow(
                          context,
                          localeLang.jobId,
                          currentEmp.jobId,
                        ),
                        _buildInfoRow(
                          context,
                          localeLang.manager,
                          currentEmp.manager,
                        ),
                        _buildInfoRow(
                          context,
                          localeLang.identification,
                          currentEmp.identificationId,
                        ),
                        _buildInfoRow(
                          context,
                          localeLang.workEmail,
                          currentEmp.workEmail,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeLang.payslipSection,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        if (payslips.lines != null &&
                            payslips.lines!.isNotEmpty) ...[
                          Text(
                            '',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ...payslips.lines!.map(
                            (l) => _buildInfoRow(
                              context,
                              _localizeLines(l.name, context),
                              l.total.toStringAsFixed(2),
                            ),
                          ),
                          SizedBox(height: 5.h),
                        ],
                        if (payslips.workedDays != null &&
                            payslips.workedDays!.isNotEmpty) ...[
                          const Divider(),
                          SizedBox(height: 8.h),
                          ...payslips.workedDays!.map(
                            (w) => Column(
                              children: [
                                _buildInfoRow(
                                  context,
                                  _localizeLines(w.name, context),
                                  '',
                                ),
                                SizedBox(height: 4.h),
                                _buildInfoRow(
                                  context,
                                  localeLang.hours,
                                  w.numberOfHours.toStringAsFixed(2),
                                ),
                                _buildInfoRow(
                                  context,
                                  localeLang.days,
                                  w.numberOfDays.toStringAsFixed(2),
                                ),
                                _buildInfoRow(
                                  context,
                                  localeLang.amount,
                                  w.amount.toStringAsFixed(2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                SizedBox(height: 16.h),
                Text(
                  localeLang.errorLoadingPayslips,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  localeLang.pleaseTryAgainLater,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          loading: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text(
                  localeLang.loadingPayslips,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoRow(BuildContext context, String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 6,
          child: Text(
            value.isEmpty ? '-' : value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}

String _localizeLines(String label, BuildContext context) {
  final l = label.toLowerCase();

  if (l == "basic salary") {
    return S.of(context).basicSalary;
  } else if (l == "taxable salary") {
    return S.of(context).texableSalary;
  } else if (l == "net salary") {
    return S.of(context).netSalary;
  } else if (l == "attendance") {
    return S.of(context).attendance;
  }
  return '';
}
