import 'package:flutter/material.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Index menu yang aktif

  // List Halaman
  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text("Halaman Ticket", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Halaman F&B", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Halaman Profile", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background belakang biar curve keliatan
      body: Stack(
        children: [
          // 1. ISI HALAMAN (Layer Bawah)
          _pages[_selectedIndex],

          // 2. NAVBAR CUSTOM (Layer Atas)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildDynamicNavbar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicNavbar(BuildContext context) {
    // Hitung lebar layar dibagi 4 (karena ada 4 menu)
    // Biar kita tau posisi X tiap tombol
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 4;

    return SizedBox(
      height: 100, // Tinggi area navbar total (termasuk nonjol ke atas)
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // A. BAR MERAH (BACKGROUND)
          Container(
            height: 70, // Tinggi bar merahnya doang
            decoration: const BoxDecoration(
              color: Color(0xFFFF3D3D), // Merah CGV
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),

          // B. BULATAN PUTIH & MERAH YANG GERAK (ANIMASI)
          // Kita pake AnimatedPositioned biar dia geser halus (Sliding)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300), // Kecepatan geser
            curve: Curves.easeInOut, // Gaya gerak (biar luwes)
            left: _selectedIndex * itemWidth, // RUMUS MATEMATIKA POSISINYA
            bottom: 25, // Posisi dari bawah (biar nongol dikit)
            child: SizedBox(
              width: itemWidth, // Lebar area per item
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. Lengkungan Putih (Background tombol)
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white, // Warna background cekungan
                        shape: BoxShape.circle,
                      ),
                    ),
                    // 2. Tombol Merah Gelap (Isi dalam)
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B1919), // Merah maroon gelap
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      // Ikon Aktif (Besar)
                      child: Icon(
                        _getIcon(_selectedIndex),
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // C. DERETAN IKON MENU (TULISAN DOANG)
          // Ini layer paling depan buat nangkep klik user
          SizedBox(
            height: 70, // Samain tinggi bar merah
            child: Row(
              children: [
                _buildNavItem(0, "Home", Icons.home_filled),
                _buildNavItem(1, "Ticket", Icons.confirmation_number),
                _buildNavItem(2, "F&B", Icons.fastfood),
                _buildNavItem(3, "Profile", Icons.person),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET TOMBOL (BIASA)
  Widget _buildNavItem(int index, String label, IconData icon) {
    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          color: Colors.transparent, // Biar bisa diklik area kosongnya
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trik Visual:
              // Kalau menu ini lagi DIPILIH (isSelected), ikon-nya kita umpetin
              // (opacity 0) karena udah diwakilin sama tombol gede yang gerak di atas.
              // Kalau GAK dipilih, baru kita munculin ikon biasa.
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 0.0 : 1.0,
                child: Icon(icon, color: Colors.white),
              ),

              const SizedBox(height: 4),

              // Teks Label (Bold kalau dipilih)
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper buat balikin ikon berdasarkan index
  IconData _getIcon(int index) {
    switch (index) {
      case 0: return Icons.home_filled;
      case 1: return Icons.confirmation_number;
      case 2: return Icons.fastfood;
      case 3: return Icons.person;
      default: return Icons.home;
    }
  }
}