import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.clickToView,
    required this.route,
    this.imageIcon,
  });
  final String route;
  final IconData? icon;
  final Widget? imageIcon;
  final String title;
  final String description;
  final String clickToView;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        imageIcon ?? Icon(
                          icon,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    maxLines: null,
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.tertiary,
                  ),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20.r),
                    ),
                  ),
                ),
                child: Text(
                  clickToView,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
