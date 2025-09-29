import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/attendance_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/app/models/empInfoModels/attendance.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen>
    with RouteAware {
  bool isCheckedIn = false;
  @override
  void initState() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          return ref
              .read(attendanceProvider.notifier)
              .getAttendance(currentToken, currentEmp);
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
              .read(attendanceProvider.notifier)
              .getAttendance(currentToken, currentEmp);
        }
      }
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false; // Location services are not enabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return false;
    }

    return true;
  }

  Future<bool> canCheckIn() async {
    bool hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      print("Location permission not granted");
      return false;
    }
    // Company location
    const double companyLat = 30.0801;
    const double companyLng = 31.3146;
    const double allowedRadius = 25; // in meters

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      companyLat,
      companyLng,
    );
    print('can check in ended-------------');
    return distanceInMeters <= allowedRadius;
  }

  void checkIn() async {
    //getting the check in time and store it locally untill the check out clicked, so that the app sends
    // both check in and out together to the server!!!
    if (await canCheckIn()) {
      setState(() {
        isCheckedIn = true;
      });
      final checkIn = DateTime.now();
      final checkInFormated = DateFormat('yyyy-MM-dd HH:mm:ss').format(checkIn);
      PrefService.saveCheckIn(checkInFormated);

      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              AppButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15.r),
            ),
            content: const Text('Check in successful!'),
          ),
        );
      }
    } else {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              AppButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15.r),
            ),
            content: const Text('Failed to Check In'),
          ),
        );
      }
    }
  }

  void checkOut() async {
    if (await canCheckIn()) {
      setState(() {
        isCheckedIn = false;
      });
      //retreiving the check in and getting check out
      final checkOut = DateTime.now();
      final checkOutFormated = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(checkOut);

      final String? checkIn = await PrefService.getCheckIn();
      final currentToken = await PrefService.getToken();
      final currentEmp = ref.read(empInfoProvider).value;
      if (currentToken != null) {
        if (currentEmp != null) {
          await ref
              .watch(attendanceProvider.notifier)
              .createAttendance(
                currentEmp,
                currentToken,
                checkIn!,
                checkOutFormated,
              );
        }
      }
      await ref
          .watch(attendanceProvider.notifier)
          .getAttendance(currentToken!, currentEmp!);
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              AppButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15.r),
            ),
            content: const Text('Check out successful!'),
          ),
        );
      }
    } else {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              AppButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15.r),
            ),
            content: const Text('Failed to Check out'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendencesAsync = ref.watch(attendanceProvider);
    Future<void> refresh() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          await ref
              .read(attendanceProvider.notifier)
              .getAttendance(currentToken, currentEmp);
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Attendance'),),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: attendencesAsync.when(
          data: (attendances) {
            // Group by month for expandable sections and show compact rows per day
            final groupedByMonth = _groupAttendancesByMonth(attendances);
            final monthKeys = groupedByMonth.keys.toList();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCheckedIn
                                  ? 'Click to Check out'
                                  : 'Click to check in',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            SizedBox(height: 4.h),
                            GestureDetector(
                              onTap: isCheckedIn ? checkOut : checkIn,
                              child: Container(
                                padding: EdgeInsets.all(30.h),
                                decoration: BoxDecoration(
                                  color: isCheckedIn
                                      ? Colors.red.withValues(alpha: 0.3)
                                      : Colors.green.withValues(alpha: 0.3),
                                  border: Border.all(
                                    color: isCheckedIn
                                        ? Colors.red
                                        : Colors.green,
                                    width: 1,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      isCheckedIn ? Icons.logout : Icons.login,
                                      size: 30.sp,
                                      color: isCheckedIn
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      isCheckedIn ? 'Check out' : 'Check In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.separated(
                      itemCount: monthKeys.length,
                      separatorBuilder: (_, __) => SizedBox(height: 6.h),
                      itemBuilder: (context, monthIndex) {
                        final monthKey = monthKeys[monthIndex];
                        final monthItems = groupedByMonth[monthKey]!;

                        final totalHours = monthItems.fold<double>(
                          0,
                          (sum, a) => sum + a.workedHrs!,
                        );

                        return Card(
                          elevation: 1,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                              splashColor: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.06),
                              highlightColor: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.04),
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 2.h,
                              ),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 6.h,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    monthKey,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      '${monthItems.length} days',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.access_time,
                                    size: 16.sp,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${totalHours.toStringAsFixed(1)} h',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                              children: [
                                Divider(
                                  height: 1.h,
                                  thickness: 0.6,
                                  color: Theme.of(
                                    context,
                                  ).dividerColor.withValues(alpha: 0.5),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: monthItems.length,
                                  separatorBuilder: (_, __) => Divider(
                                    height: 1.h,
                                    thickness: 0.6,
                                    color: Theme.of(
                                      context,
                                    ).dividerColor.withValues(alpha: 0.5),
                                  ),
                                  itemBuilder: (context, index) {
                                    final item = monthItems[index];
                                    final isEqual = item.workedHrs == 8;
                                    final isGreater = item.workedHrs! > 8;
                                    final day = item.checkIn;
                                    final checkInStr = DateFormat(
                                      'HH:mm',
                                    ).format(item.checkIn);
                                    final checkOutStr = item.checkOut == null
                                        ? ""
                                        : DateFormat(
                                            'HH:mm',
                                          ).format(item.checkOut!);
                                    final weekdayStr = DateFormat(
                                      'EEE, dd',
                                    ).format(day);

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 6.h,
                                      ),
                                      child: Row(
                                        children: [
                                          // Day badge
                                          Container(
                                            width: 36.w,
                                            height: 36.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Text(
                                              DateFormat('d').format(day),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          // Details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  weekdayStr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                SizedBox(height: 2.h),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.login,
                                                      size: 14.sp,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(width: 4.w),
                                                    Text(
                                                      checkInStr,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodySmall,
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Icon(
                                                      Icons.logout,
                                                      size: 14.sp,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(width: 4.w),
                                                    Text(
                                                      checkOutStr,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Hours chip
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isEqual
                                                  ? Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary
                                                        .withValues(alpha: 0.1)
                                                  : isGreater
                                                  ? Colors.green.withValues(
                                                      alpha: 0.1,
                                                    )
                                                  : Colors.red.withValues(
                                                      alpha: 0.1,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              border: Border.all(
                                                color: isEqual
                                                    ? Theme.of(context)
                                                          .colorScheme
                                                          .onTertiary
                                                          .withValues(
                                                            alpha: 0.3,
                                                          )
                                                    : isGreater
                                                    ? Colors.green.withValues(
                                                        alpha: 0.3,
                                                      )
                                                    : Colors.red.withValues(
                                                        alpha: 0.3,
                                                      ),
                                              ),
                                            ),
                                            child: Text(
                                              '${(item.workedHrs)!.toStringAsFixed(1)} h',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: isEqual
                                                        ? Theme.of(context)
                                                              .colorScheme
                                                              .onTertiary
                                                        : isGreater
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                  'Error Loading Attendance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please try again later',
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
                  'Loading Attendance...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, List<Attendance>> _groupAttendancesByMonth(
    List<Attendance> attendances,
  ) {
    // Ensure stable order: newest month first, newest day first
    attendances.sort((a, b) => b.checkIn.compareTo(a.checkIn));
    final Map<String, List<Attendance>> grouped = {};
    for (final item in attendances) {
      final key = DateFormat('MMMM yyyy').format(item.checkIn);
      grouped.putIfAbsent(key, () => <Attendance>[]).add(item);
    }
    // Sort each month's days descending for quick recent access
    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => b.checkIn.compareTo(a.checkIn));
    }
    return grouped;
  }
}
