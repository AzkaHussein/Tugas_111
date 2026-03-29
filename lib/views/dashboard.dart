import 'package:flutter/material.dart';
import 'package:kasir_1/models/user_login.dart';
import 'package:kasir_1/widgets/bottom_nav.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await UserLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Selamat Datang $nama\nRole: $role",
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
