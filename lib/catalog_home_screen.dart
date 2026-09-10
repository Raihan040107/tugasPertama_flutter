import 'package:flutter/material.dart';

import 'catalog_detail_screen.dart';

/// Model sederhana untuk satu item katalog.
/// Dipakai bersama oleh Screen 1 (Beranda) dan Screen 2 (Detail Katalog).
class CatalogItem {
  final String name;
  final String tagline;
  final String price;
  final String priceSuffix;
  final String description;
  final List<String> features;
  final IconData icon;
  final Color pastelColor;
  final bool isPopular;

  const CatalogItem({
    required this.name,
    required this.tagline,
    required this.price,
    required this.priceSuffix,
    required this.description,
    required this.features,
    required this.icon,
    required this.pastelColor,
    this.isPopular = false,
  });
}

/// SCREEN 1 - BERANDA
/// Wajib StatelessWidget.
/// Data ditampilkan dengan ListView berisi 3 cards (ListTile yang bisa diklik).
/// Gaya visual (putih, sudut membulat, shadow, aksen indigo/amber) disamakan
/// dengan tampilan PricingCard pada tugas sebelumnya.
class CatalogHomeScreen extends StatelessWidget {
  const CatalogHomeScreen({super.key});

  // Data dummy 3 item katalog.
  static final List<CatalogItem> catalogList = [
    CatalogItem(
      name: 'Paket Website Bisnis',
      tagline: 'Solusi company profile untuk tampil profesional secara online',
      price: 'Rp 3.500.000',
      priceSuffix: '/ proyek',
      description:
          'Pembuatan website company profile lengkap dengan desain '
          'responsif, optimasi SEO dasar, dan integrasi form kontak '
          'untuk membantu bisnis tampil profesional secara online.',
      features: const [
        'Desain UI/UX Responsif',
        'Optimasi SEO Dasar',
        'Integrasi Form Kontak',
        'Support 24/7 Selama 1 Bulan',
      ],
      icon: Icons.language,
      pastelColor: const Color(0xFFDCEEFB),
      isPopular: true,
    ),
    CatalogItem(
      name: 'Paket Aplikasi Mobile',
      tagline: 'Aplikasi Android & iOS custom dengan performa maksimal',
      price: 'Rp 7.500.000',
      priceSuffix: '/ proyek',
      description:
          'Pengembangan aplikasi mobile Android & iOS menggunakan '
          'Flutter, mencakup UI/UX kustom, integrasi API, serta '
          'pengujian di berbagai perangkat sebelum rilis ke store.',
      features: const [
        'Desain UI/UX Kustom',
        'Integrasi API Pihak Ketiga',
        'Pengujian Multi Perangkat',
        'Support 24/7 Selama 1 Bulan',
      ],
      icon: Icons.phone_android,
      pastelColor: const Color(0xFFFDE8E8),
    ),
    CatalogItem(
      name: 'Paket Maintenance Sistem',
      tagline: 'Pemeliharaan rutin agar sistem tetap stabil & aman',
      price: 'Rp 1.200.000',
      priceSuffix: '/ bulan',
      description:
          'Layanan pemeliharaan rutin sistem, mencakup monitoring '
          'server, backup data berkala, perbaikan bug, dan dukungan '
          'teknis prioritas selama masa kontrak berlangsung.',
      features: const [
        'Monitoring Server 24/7',
        'Backup Data Berkala',
        'Perbaikan Bug Prioritas',
        'Laporan Bulanan',
      ],
      icon: Icons.build_circle,
      pastelColor: const Color(0xFFE8F5E9),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Layanan IT'),
        centerTitle: true,
      ),
      // ListView berisi 3 cards
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        itemCount: catalogList.length,
        itemBuilder: (context, index) {
          final item = catalogList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Kartu utama -> gaya disamakan dengan PricingCard
                // (putih, radius 20, shadow lembut)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: item.pastelColor,
                        child: Icon(item.icon, color: Colors.indigo),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${item.price} ${item.priceSuffix}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.indigo,
                      ),
                      // Stack Navigation: Navigator.push dari Screen 1 ke Screen 2
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CatalogDetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Badge "Populer" -> Stack + Positioned, persis seperti
                // badge "Rekomendasi" pada PricingCard tugas sebelumnya.
                if (item.isPopular)
                  Positioned(
                    top: -10,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Populer',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
