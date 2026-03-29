import 'package:flutter/material.dart';
import 'package:kasir_1/LoginView/login_view.dart';
import 'package:kasir_1/views/dashboard.dart';
import 'package:kasir_1/views/movie_view.dart';
import 'package:kasir_1/views/pesan_view.dart';
import 'package:kasir_1/views/register_user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterUserView(),
        '/dashboard': (context) => const DashboardView(),
        '/movie': (context) => const MovieView(),
        '/pesan': (context) => const PesanView(),
      },
    );
  }
}