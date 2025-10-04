import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/time_offs_provider.dart';
import 'package:employee_service_system/app/providers/startDataProviders/timeoff_types_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:employee_service_system/presentation/employee/timeOff/widget/create_time_off_sheet.dart';
import 'package:employee_service_system/presentation/employee/timeOff/widget/time_off_card.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeoffScreen extends ConsumerStatefulWidget {
  const TimeoffScreen({super.key});

  @override
  ConsumerState<TimeoffScreen> createState() => _TimeoffScreenState();
}

class _TimeoffScreenState extends ConsumerState<TimeoffScreen> with RouteAware {
  @override
  void initState() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        ref.read(timeoffTypesProvider.notifier).getTimeoffsTypes(currentToken);
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          return ref
              .read(timeOffProvider.notifier)
              .getTimeOffs(currentEmp, currentToken);
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
        if (currentEmp != null) {
          return ref
              .read(timeOffProvider.notifier)
              .getTimeOffs(currentEmp, currentToken);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localLang = S.of(context);
    final timeOffsAsync = ref.watch(timeOffProvider);
    Future<void> refresh() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          await ref
              .read(timeOffProvider.notifier)
              .getTimeOffs(currentEmp, currentToken);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(localLang.timeOffTitle)),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _openCreateSheet,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          localLang.requestTimeOff,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: timeOffsAsync.when(
          data: (timeOffs) {
            if (timeOffs.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        localLang.noTimeOffRecords,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              );
            }
            final totals = _buildTotals(timeOffs.map((t) => t.state).toList());
            final int requestedHours = timeOffs.fold<int>(
              0,
              (sum, t) => sum + t.dateTo.difference(t.dateFrom).inHours,
            );
            const int? availableHours = null;

            return RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BalanceHeader(
                    availableHours: availableHours,
                    requestedHours: requestedHours,
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: [
                      // _buildStatChip(
                      //   context,
                      //   'Total',
                      //   totals.total,
                      //   Colors.blue,
                      // ),
                      _buildStatChip(
                        context,
                        localLang.approved,
                        totals.approved,
                        Colors.green,
                      ),
                      _buildStatChip(
                        context,
                        localLang.pending,
                        totals.pending,
                        Colors.orange,
                      ),
                      _buildStatChip(
                        context,
                        localLang.refused,
                        totals.refused,
                        Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: timeOffs.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final t = timeOffs[index];
                        return TimeOffCard(timeOff: t);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          error: (e, st) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                SizedBox(height: 8.h),
                Text(
                  'Failed to load time off',
                  style: Theme.of(context).textTheme.titleMedium,
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
                  localLang.loadingTimeoff,
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

_Totals _buildTotals(List<String> states) {
  int approved = 0, pending = 0, refused = 0;
  for (final s in states) {
    switch (s.toLowerCase()) {
      case 'approved':
      case 'validate':
      case 'done':
        approved++;
        break;
      case 'pending':
      case 'to approve':
      case 'draft':
      case 'confirm':
        pending++;
        break;
      case 'refused':
      case 'cancelled':
      case 'cancel':
        refused++;
        break;
    }
  }
  return _Totals(
    total: states.length,
    approved: approved,
    pending: pending,
    refused: refused,
  );
}

class _Totals {
  _Totals({
    required this.total,
    required this.approved,
    required this.pending,
    required this.refused,
  });
  final int total;
  final int approved;
  final int pending;
  final int refused;
}

Widget _buildStatChip(
  BuildContext context,
  String label,
  int value,
  Color color,
) {
  return Chip(
    backgroundColor: color.withValues(alpha: 0.08),
    side: BorderSide(color: color.withValues(alpha: 0.2)),
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    ),
    shape: const StadiumBorder(),
  );
}

class _BalanceHeader extends StatelessWidget {
  const _BalanceHeader({
    required this.availableHours,
    required this.requestedHours,
  });
  final int? availableHours;
  final int requestedHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).availableHours,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4.h),
                Text(
                  availableHours?.toString() ?? '-',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(color: Colors.white24, thickness: 1, width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).requestedHours,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4.h),
                Text(
                  requestedHours.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on _TimeoffScreenState {
  Future<void> _openCreateSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20.r),
      ),
      builder: (ctx) => const CreateTimeOffSheet(),
    );

    final currentToken = await PrefService.getToken();
    if (currentToken != null) {
      final currentEmp = ref.read(empInfoProvider).value;
      if (currentEmp != null) {
        await ref
            .read(timeOffProvider.notifier)
            .getTimeOffs(currentEmp, currentToken);
      }
    }
  }
}
