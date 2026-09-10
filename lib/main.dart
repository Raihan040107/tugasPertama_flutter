import 'package:flutter/material.dart';

import 'catalog_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Layanan IT',
      // Palet & tema disamakan dengan tugas sebelumnya:
      // indigo sebagai warna utama, background abu-abu muda.
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF2F3F7),
      ),
      // Screen 1 (Beranda) langsung menjadi halaman utama aplikasi.
      home: const CatalogHomeScreen(),
    );
  }
}
