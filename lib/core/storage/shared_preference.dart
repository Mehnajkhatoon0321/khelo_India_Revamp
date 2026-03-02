import 'package:shared_preferences/shared_preferences.dart';

class Prefs {

  static SharedPreferences? prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs != null;
  }

  // Remember Me
  static Future<void> setRememberMe(bool value) async {
    await prefs?.setBool('rememberMe', value);
  }

  static bool getRememberMe() {
    return prefs?.getBool('rememberMe') ?? false;
  }

  // User Email
  static Future<void> setUserEmailLogin(String email) async {
    await prefs?.setString('userEmail', email);
  }

  static String getUserEmailLogin() {
    return prefs?.getString('userEmail') ?? '';
  }

  // User Password
  static Future<void> setUserPassword(String password) async {
    await prefs?.setString('userPassword', password);
  }

  static String getUserPassword() {
    return prefs?.getString('userPassword') ?? '';
  }

  // Auth Token
  static Future<void> setToken(String token) async {
    await prefs?.setString('authToken', token);
  }

  static String getToken() {
    return prefs?.getString('authToken') ?? '';
  }

  // App Version
  static Future<void> setAppVersion(String version) async {
    await prefs?.setString('app_version', version);
  }

  static String getAppVersion() {
    return prefs?.getString('app_version') ?? '';
  }

  // App Build Number
  static Future<void> setAppBuildNumber(String buildNumber) async {
    await prefs?.setString('app_build_number', buildNumber);
  }

  static String getAppBuildNumber() {
    return prefs?.getString('app_build_number') ?? '';
  }

  // Account Type
  static Future<void> setAccountType(String accountType) async {
    await prefs?.setString('account_type', accountType);
  }

  static String getAccountType() {
    return prefs?.getString('account_type') ?? '';
  }
  static void setCategory(int value) {
    Prefs.prefs?.setInt('category', value);
  }

  static int getCategory() {
    final int? value = Prefs.prefs?.getInt('category');
    return value ?? 0; // Return 0 if no value is found
  }


}