import 'package:employee_service_system/app/providers/adminProviders/admin_auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const _isLoggedIn = "isLoggedIn";

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedIn, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedIn) ?? false;
  }

  static Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedIn, false);
  }

  static Future<void> saveToken(ref) async {
    try {
      final currentUser = await ref.read(adminAuthProvider);
      if (currentUser.hasValue && currentUser.value != null) {
        print('INSIDE SAVETOKEN---------------${currentUser.value!.token}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', currentUser.value!.token);
      } else {
        print('Error: No valid user data to save token');
      }
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<void> saveCheckIn(String checkIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('check_in', checkIn);
  }

  static Future<void> saveCheckInState(bool isCheckin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_checkIn', isCheckin);
  }

  static Future<bool?> getCheckInState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_checkIn',)?? false;
  }

  static Future<String?> getCheckIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('check_in');
  }
}
