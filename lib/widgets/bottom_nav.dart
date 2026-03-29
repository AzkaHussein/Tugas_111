import 'package:flutter/material.dart';
import 'package:kasir_1/models/user_login.dart';

class BottomNav extends StatefulWidget {
  final int activePage;
  const BottomNav(this.activePage, {super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String? role;

  Future<void> getLogin() async {
    var user = await UserLogin.getUserLogin();

    if (user.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  void changePage(int index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/movie');
      }
    }

    if (role == "kasir") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/pesan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role == null) return const SizedBox();

    return BottomNavigationBar(
      currentIndex: widget.activePage,
      onTap: changePage,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: role == "admin"
          ? const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie), label: "Movie"),
            ]
          : const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Pesan"),
            ],
    );
  }
}