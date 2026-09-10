import 'package:flutter/material.dart';

import 'catalog_home_screen.dart';

/// SCREEN 2 - DETAIL KATALOG
/// Wajib StatefulWidget (tantangan tambahan: ada state favorit yang berubah).
/// Tata letak utama menggunakan Column (vertikal).
/// Gaya visual (kartu putih radius 20 + shadow, aksen indigo) disamakan
/// dengan tampilan PricingCard pada tugas sebelumnya.
class CatalogDetailScreen extends StatefulWidget {
  final CatalogItem item;

  const CatalogDetailScreen({super.key, required this.item});

  @override
  State<CatalogDetailScreen> createState() => _CatalogDetailScreenState();
}

class _CatalogDetailScreenState extends State<CatalogDetailScreen> {
  // State sederhana untuk memenuhi syarat StatefulWidget:
  // tombol favorit yang bisa ditoggle.
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      // AppBar wajib ada -> tombol "Kembali" bawaan otomatis tersedia
      // (leading back arrow dari Navigator otomatis muncul di sini).
      appBar: AppBar(
        title: const Text('Detail Katalog'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        // Tata letak vertikal -> Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon back tambahan (selain back bawaan AppBar) yang
            // difungsikan untuk kembali ke Screen 1.
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(30),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.arrow_back_ios_new, size: 22),
              ),
            ),
            const SizedBox(height: 16),

            // Kartu utama -> gaya disamakan dengan PricingCard
            // (putih, radius 20, shadow lembut)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: item.pastelColor,
                    child: Icon(item.icon, size: 32, color: Colors.indigo),
                  ),
                  const SizedBox(height: 16),

                  // Text untuk nama katalog
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Text untuk harga
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Container dengan latar belakang pastel + padding
                  // sebagai tempat deskripsi singkat / bio.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item.pastelColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi Layanan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol CTA -> gaya sama seperti "Pilih Paket" sebelumnya
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Kembali ke Katalog'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
