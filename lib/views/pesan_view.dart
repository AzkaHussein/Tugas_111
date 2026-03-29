import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class PesanView extends StatelessWidget {
  const PesanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text("Halaman Pesanan"),
      ),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}