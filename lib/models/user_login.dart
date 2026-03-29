import 'package:shared_preferences/shared_preferences.dart';

class UserLogin {
  bool status;
  String token;
  String message;
  int id;
  String nama_user;
  String email;
  String role;

  UserLogin({
    this.status = false,
    this.token = "",
    this.message = "",
    this.id = 0,
    this.nama_user = "",
    this.email = "",
    this.role = "",
  });

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("status", status);
    await prefs.setString("token", token);
    await prefs.setString("message", message);
    await prefs.setInt("id", id);
    await prefs.setString("nama_user", nama_user);
    await prefs.setString("email", email);
    await prefs.setString("role", role);
  }

  static Future<UserLogin> getUserLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return UserLogin(
      status: prefs.getBool("status") ?? false,
      token: prefs.getString("token") ?? "",
      message: prefs.getString("message") ?? "",
      id: prefs.getInt("id") ?? 0,
      nama_user: prefs.getString("nama_user") ?? "",
      email: prefs.getString("email") ?? "",
      role: prefs.getString("role") ?? "",
    );
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
