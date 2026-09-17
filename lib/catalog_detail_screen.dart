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
  // ================== EVENT & STATE ==================
  // Alur umum di seluruh screen ini selalu sama:
  // 1. EVENT   -> user menekan sesuatu (tap tombol/icon), dijalankan
  //               lewat callback seperti onPressed / onTap.
  // 2. HANDLER -> fungsi (mis. _toggleFavorite, _increment) mengubah
  //               nilai variabel di dalam State class ini.
  // 3. setState(() {...}) -> memberi tahu Flutter "data sudah berubah,
  //               tolong panggil ulang build()".
  // 4. build() dipanggil ulang -> UI otomatis menampilkan nilai terbaru.
  // Tanpa setState, perubahan variabel TIDAK akan terlihat di layar,
  // walau nilainya sudah berubah di memori.
  // =====================================================

  // --- STATE 1: Wishlist / Favorit ---
  // isFavorite TIDAK disimpan sebagai variabel lokal biasa, tapi dibaca
  // langsung dari CatalogHomeScreen.favoriteNames (Set statis) supaya
  // status wishlist "nempel" ke setiap item dan tetap ada walau
  // Screen 2 ditutup dan dibuka lagi dari item lain.
  bool get _isFavorite =>
      CatalogHomeScreen.favoriteNames.contains(widget.item.name);

  // EVENT: dipanggil saat icon hati di AppBar ditekan.
  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        CatalogHomeScreen.favoriteNames.remove(widget.item.name);
      } else {
        CatalogHomeScreen.favoriteNames.add(widget.item.name);
      }
    });

    // Side-effect dari event (bukan cuma ubah UI): tampilkan notifikasi
    // singkat lewat SnackBar, contoh event yang memicu aksi lain
    // selain setState.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          _isFavorite
              ? '${widget.item.name} ditambahkan ke wishlist'
              : '${widget.item.name} dihapus dari wishlist',
        ),
      ),
    );
  }

  // --- STATE 2: Jumlah pesanan (quantity stepper) ---
  // Contoh state "angka" yang beda bentuk dari state boolean di atas,
  // supaya konsep event & state terlihat dalam bentuk yang lain juga.
  int _quantity = 1;

  // EVENT: tombol "+" ditekan.
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  // EVENT: tombol "-" ditekan. Diberi batas minimal 1 supaya jumlah
  // pesanan tidak bisa menjadi 0 atau negatif.
  void _decrementQuantity() {
    if (_quantity <= 1) return;
    setState(() {
      _quantity--;
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

                  // --- Quantity Stepper: contoh event & state kedua ---
                  // Row berisi label "Jumlah" di kiri, dan tombol -/angka/+
                  // di kanan. Nilai _quantity ditampilkan langsung dari
                  // state, jadi begitu setState dipanggil, angka di
                  // tengah otomatis ikut berubah.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah Pesanan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F3F7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.indigo,
                              onPressed: _decrementQuantity,
                            ),
                            SizedBox(
                              width: 28,
                              child: Text(
                                '$_quantity',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.indigo,
                              onPressed: _incrementQuantity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tombol CTA -> gaya sama seperti "Pilih Paket" sebelumnya.
                  // Sekarang ikut menampilkan jumlah pesanan dari state,
                  // sebagai bukti nyata state dipakai, bukan cuma dipajang.
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$_quantity x ${item.name} ditambahkan',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Pilih Paket ($_quantity)'),
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
