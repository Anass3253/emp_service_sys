import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:employee_service_system/routing/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final isLoggedIn = await PrefService.isLoggedIn();

    if (isLoggedIn) {
      // Check if we have a token and try to load employee data
      final token = await PrefService.getToken();
      if (token != null) {
        try {
          // Try to load employee data first
          // Note: This is a simplified approach - in a real app you might want to
          // store employee ID in preferences or handle this differently
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.appInit);
          }
        } catch (e) {
          // If loading fails, go to signin
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.signin);
          }
        }
      } else {
        // No token, go to signin
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.signin);
        }
      }
    } else {
      // Not logged in, go to signin
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.signin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Brightness currentTheme = Theme.of(context).brightness;
    final bool isDark = currentTheme == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          isDark
              ? "assets/images/blue logo animate.gif"
              : "assets/images/logo animate.gif",
        ),
      ),
    );
  }
}
