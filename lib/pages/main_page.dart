import 'package:flutter/material.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // List Halaman
  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text("Halaman Ticket", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Halaman F&B", style: TextStyle(fontSize: 24))),
    const Center(
      child: Text("Halaman Profile", style: TextStyle(fontSize: 24)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          _pages[_selectedIndex],

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
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 4;

    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFFF3D3D),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _selectedIndex * itemWidth,
            bottom: 25,
            child: SizedBox(
              width: itemWidth,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B1919),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
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

          SizedBox(
            height: 70,
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
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 0.0 : 1.0,
                child: Icon(icon, color: Colors.white),
              ),

              const SizedBox(height: 4),

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
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.confirmation_number;
      case 2:
        return Icons.fastfood;
      case 3:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
