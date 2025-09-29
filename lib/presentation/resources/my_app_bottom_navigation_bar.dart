import 'package:flutter/material.dart';

class MyAppBottomNavigationBar extends StatefulWidget {
  const MyAppBottomNavigationBar({
    super.key,
    required this.screens,
    required this.icons,
    required this.labels,
    this.showAppBar = true,
  });

  final List<Widget> screens;
  final List<IconData> icons;
  final List<String> labels;
  final bool showAppBar;

  @override
  State<MyAppBottomNavigationBar> createState() =>
      _MyAppBottomNavigationBarState();
}

class _MyAppBottomNavigationBarState extends State<MyAppBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: widget.screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onTertiary),
        selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        selectedItemColor: Theme.of(context).colorScheme.onTertiary,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: List.generate(
          widget.screens.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(widget.icons[index]),
            label: widget.labels[index],
          ),
        ),
      ),
    );
  }
}
