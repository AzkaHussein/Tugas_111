import 'package:flutter/material.dart';

class AlertPopup {
  void show(BuildContext context, String message, bool status) {
    Color warna;
    IconData icon;

    if (status) {
      warna = Colors.red;
      icon = Icons.check_circle;
    } else {
      warna = Colors.red[800]!;
      icon = Icons.error;
    }

    showDialog(
      context: context,
      barrierDismissible: false, // harus tekan tombol
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(icon, color: warna),
              const SizedBox(width: 10),
              Text(
                status ? "Berhasil" : "Gagal",
                style: TextStyle(color: warna),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: warna,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
