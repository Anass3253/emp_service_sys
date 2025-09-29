import 'package:flutter/material.dart';

class GradientAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GradientAppbar({
    super.key,
    required this.title,
    required this.gradient,
    this.actions,
    this.centerTitle = true,
    this.imagePath,
  });

  final String title;
  final Gradient gradient;
  final List<Widget>? actions;
  final bool centerTitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: imagePath == null
          ? Text(title)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath!),
                  radius: 25,
                  backgroundColor: Colors.transparent,
                ),
                Text(title),
              ],
            ),
      actions: actions,
      centerTitle: centerTitle,
      flexibleSpace: Container(decoration: BoxDecoration(gradient: gradient)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
