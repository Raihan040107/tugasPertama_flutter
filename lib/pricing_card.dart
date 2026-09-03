import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  const PricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LAYER DASAR (PEMBUNGKUS UTAMA) -> Container
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // 2. BADGE MELAYANG -> Stack + Positioned
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Lapisan bawah: konten utama kartu
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. HEADER PAKET -> Column
              const Icon(Icons.laptop_mac, size: 48, color: Colors.indigo),
              const SizedBox(height: 12),
              const Text(
                'Paket Profesional',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Solusi lengkap untuk kebutuhan digital bisnis Anda',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              // 4. HARGA & DURASI -> Row dengan alignment baseline
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Rp 5.000.000',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '/ proyek',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),

              // Jarak kosong sebelum daftar fitur
              const SizedBox(height: 20),

              // 5. DAFTAR FITUR LAYANAN -> Column berisi beberapa Row
              const FeatureRow(text: 'Desain UI/UX Khusus'),
              const SizedBox(height: 8),
              const FeatureRow(text: 'Setup Database'),
              const SizedBox(height: 8),
              const FeatureRow(text: 'Integrasi API Pihak Ketiga'),
              const SizedBox(height: 8),
              const FeatureRow(text: 'Support 24/7 Selama 1 Bulan'),

              const SizedBox(height: 20),

              // 6. TOMBOL CALL-TO-ACTION -> SizedBox lebar penuh + ElevatedButton
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Pilih Paket'),
                ),
              ),
            ],
          ),

          // Lapisan atas: badge "Rekomendasi" di sudut kanan atas
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Rekomendasi',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget kecil untuk satu baris fitur: Icon(check) + Text
// Dibuat terpisah supaya kode Column fitur tidak berulang-ulang (reusable widget)
class FeatureRow extends StatelessWidget {
  final String text;

  const FeatureRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 18, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
